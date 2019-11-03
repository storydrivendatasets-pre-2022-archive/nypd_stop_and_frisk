#!/usr/bin/env python

import csv
from pathlib import Path
import re
from sys import argv
from xlrd import open_workbook, XL_CELL_DATE, xldate_as_datetime
from zipfile import ZipFile

SRC_DIR = Path('data', 'stashed', 'nypd')
DEST_DIR = SRC_DIR.joinpath('csv')


def extract_csv_from_xlsx(fpath):
    book = open_workbook(fpath)
    sheet = book.sheets()[0]
    colcount = sheet.row_len(0)
    rowcount = sheet.nrows

    data = []
    for i in range(rowcount):
        drow = []
        for j in range(colcount):
            cell = sheet.cell(i, j)
            if cell.ctype == XL_CELL_DATE:
                val = xldate_as_datetime(cell.value, book.datemode).isoformat()[0:10]
            else:
                val = cell.value
            drow.append(val)
        data.append(drow)
    return data


def process_xlsxes(srcpaths):
    DEST_DIR.mkdir(exist_ok=True, parents=True)
    for src in srcpaths:
        print("Opening", src)
        data = extract_csv_from_xlsx(src)
        dest_path = DEST_DIR.joinpath(src.stem + '.csv')
        with open(dest_path, 'w') as w:
            print("Writing", dest_path)
            outs = csv.writer(w)
            outs.writerows(data)

def process_zips(srcpaths):
    DEST_DIR.mkdir(exist_ok=True, parents=True)
    for src in srcpaths:
        fname, txt = extract_csv_from_zip(src)
        print("Read", fname, "from:", src)

        # all zipped file names are in 20xx.csv format
        dest_path = DEST_DIR.joinpath(fname)

        print("Writing", dest_path)
        dest_path.write_bytes(txt)

def extract_csv_from_zip(fpath):
    z = ZipFile(fpath)
    f = z.filelist[0]
    return (f.filename, z.read(f))


def extract_single_year(year):
    fname = next(SRC_DIR.glob(f'**/{year}.*'), False)
    if not fname:
        raise ValueError(f'Unexpected year value: {year}')
    else:
        if 'zip' in str(fname):
            process_zips([fname])
        elif 'xlsx' in str(fname):
            process_xlsxes([fname])
        else:
            raise ValueError(f'Did not find zip/csv path; found: {fname}')

def main():
    process_zips(sorted(SRC_DIR.joinpath('zip').glob('*.zip')))
    process_xlsxes(sorted(SRC_DIR.joinpath('xlsx').glob('*.xlsx')))

if __name__ == '__main__':
    if len(argv) > 1:
        year = re.search(r'20\d\d', argv[1]).group()
        extract_single_year(year)
    else:
        main()
