#!/usr/bin/env python

from pathlib import Path
import re
import requests
from sys import argv
from urllib.parse import urljoin

BASE_URL = 'https://www1.nyc.gov/'
DEST_DIR = Path('data', 'stashed', 'nypd')
HREFS = Path('data', 'lookups', 'url_list.txt').read_text().splitlines()


def fetch_single_year(year):
    """
    TODO: Write Makefile to do single year fetching if necessary
    """
    href = next((h for h in HREFS if str(year) in h and re.match(r'\d{4}', tear)), False)
    if not href:
        raise ValueError(f'Unexpected year string: {year}')
    else:
        fetch_and_write(href)

def fetch_and_write(href):
    year = re.search(r'20\d\d', href).group()
    url = urljoin(BASE_URL, href)
    print(year, "Fetching:", url)

    resp = requests.get(url)
    if resp.status_code == 200:
        fext = re.search(r'\w+$', href).group()
        dest_path = DEST_DIR.joinpath(fext, f'{year}.{fext}')
        dest_path.parent.mkdir(exist_ok=True, parents=True)
        print(f"Saving {len(resp.content)} bytes to: f{dest_path}")
        dest_path.write_bytes(resp.content)

    else:
        print("Error fetching", url, "\n")
        print("\tStatus code:", resp.status_code)


def main():
    for href in HREFS:
        fetch_and_write(href)


if __name__ == '__main__':
    if len(argv) > 1:
        year = re.search(r'20\d\d', argv[1]).group()
        extract_single_year(year)
    else:
        main()


