#
# :date: 2019-12-20
# :author: PN
# :copyright: GPL v2 or later
#
# ice-ero-lesa/us/concat/src/concat.py
#
#
import pandas as pd
import argparse
import sys
import yaml
import logging
if sys.version_info[0] < 3:
    raise "Must be using Python 3"


def _get_args():
    parser = argparse.ArgumentParser()
    parser.add_argument("--dtypes", required=True)
    parser.add_argument("--input_fy16", required=True)
    parser.add_argument("--input_fy17", required=True)
    parser.add_argument("--input_fy18", required=True)
    parser.add_argument("--input_fy19", required=True)
    parser.add_argument("--output", required=True)
    return parser.parse_args()

if __name__ == "__main__":

    logging.basicConfig(filename='output/concat.log',
                    filemode='a',
                    format=f'%(asctime)s|%(message)s',
                    datefmt='%Y-%m-%d %H:%M:%S',
                    level=logging.INFO)

    logging.info('Log Start Time')

    args = _get_args()

    with open(args.dtypes, 'r') as yamlfile:
        dtypes = yaml.safe_load(yamlfile)

    read_csv_opts = {'sep': '|',
                     'quotechar': '"',
                     'compression': 'gzip',
                     'encoding': 'utf-8',
                     'header': 5}

    input_fy16 = pd.read_csv(args.input_fy16, **read_csv_opts, dtype=dtypes)
    logging.info(f'Input file: {args.input_fy16}')
    logging.info(f'Rows in: {len(input_fy16)}')
    input_fy17 = pd.read_csv(args.input_fy17, **read_csv_opts, dtype=dtypes)
    logging.info(f'Input file: {args.input_fy17}')
    logging.info(f'Rows in: {len(input_fy17)}')
    input_fy18 = pd.read_csv(args.input_fy18, **read_csv_opts, dtype=dtypes)
    logging.info(f'Input file: {args.input_fy18}')
    logging.info(f'Rows in: {len(input_fy18)}')
    input_fy19 = pd.read_csv(args.input_fy19, **read_csv_opts, dtype=dtypes)
    logging.info(f'Input file: {args.input_fy19}')
    logging.info(f'Rows in: {len(input_fy19)}')

    files = [input_fy16,
             input_fy17,
             input_fy18,
             input_fy19]

    df = pd.concat(files, sort=False)

    df.columns = df.columns.str.lower()
    df.columns = df.columns.str.replace(' ', '_')

    df['id'] = range(len(df))

    write_csv_opts = {'sep': '|',
                      'quotechar': '"',
                      'compression': 'gzip',
                      'encoding': 'utf-8',
                      'index': False}

    df.to_csv(args.output, **write_csv_opts)
    logging.info(f'Output file: {args.output}')
    logging.info(f'Rows out: {len(df)}')
    logging.info('Log End Time')

# END.
