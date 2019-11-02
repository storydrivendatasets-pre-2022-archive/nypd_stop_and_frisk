#!/usr/bin/env python

import csv
from pathlib import Path
import re
from xlrd import open_workbook, XL_CELL_DATE, xldate_as_datetime

SRC_DIR = Path('data', 'stashed', )
DEST_DIR = SRC_DIR.joinpath('csv')

def process_xlsxes():
    srcpaths = SRC_DIR.joinpath('xlsx').glob('*.xlsx')
    for src in srcpaths:
        print("Opening", src)
        data = extract_csv_from_xlsx(src)
        dest_path = DEST_DIR.joinpath(src.stem + '.csv')
        with open(dest_path, 'w') as w:
            print("Writing", dest_path)
            outs = csv.writer(w)
            outs.writerows(data)

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


def extract_csv_from_zip(fpath):
    pass



def main():
    process_xlsxes()

if __name__ == '__main__':
    main()
