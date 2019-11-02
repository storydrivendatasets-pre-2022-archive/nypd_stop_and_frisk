#!/usr/bin/env python

from pathlib import Path
import re
import requests
from urllib.parse import urljoin


BASE_URL = 'https://www1.nyc.gov/'
DEST_DIR = Path('data', 'stashed')
HREFS = Path('data', 'lookups', 'url_list.txt').read_text().splitlines()



def main():
    for href in HREFS:
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

if __name__ == '__main__':
    main()


