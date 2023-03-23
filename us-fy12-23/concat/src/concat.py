#
# :date: 2023-03-23
# :author: PN
# :copyright: GPL v2 or later
#
# ice-ero-lesa/us-fy12-23/concat/src/concat.py
#
#
import pandas as pd
import argparse
import sys
import yaml
import logging
import hashlib
if sys.version_info[0] < 3:
    raise "Must be using Python 3"


def _get_args():
    parser = argparse.ArgumentParser()
    parser.add_argument("--input_fy12", required=True)
    parser.add_argument("--input_fy13", required=True)
    parser.add_argument("--input_fy14", required=True)
    parser.add_argument("--input_fy15", required=True)
    parser.add_argument("--input_fy16", required=True)
    parser.add_argument("--input_fy17", required=True)
    parser.add_argument("--input_fy18", required=True)
    parser.add_argument("--input_fy19", required=True)
    parser.add_argument("--input_fy20", required=True)
    parser.add_argument("--input_fy21", required=True)
    parser.add_argument("--input_fy22", required=True)
    parser.add_argument("--input_fy23", required=True)
    parser.add_argument("--output", required=True)
    return parser.parse_args()

def make_hashid(row):
    try:
        s = ''.join([str(getattr(row, f)) for f in hash_fields])
    except:
        print(row)
        raise
    b = bytearray(f"{args.output}{s}", encoding='utf8')
    h = hashlib.sha1()
    h.update(b)
    return h.hexdigest()

if __name__ == "__main__":

    logging.basicConfig(filename='output/concat.log',
                    filemode='a',
                    format=f'%(asctime)s|%(message)s',
                    datefmt='%Y-%m-%d %H:%M:%S',
                    level=logging.INFO)

    logging.info('Log Start Time')

    args = _get_args()

    read_csv_opts = {'sep': '|',
                     'quotechar': '"',
                     'compression': 'gzip',
                     'encoding': 'utf-8',
                     'header': 5}

    input_fy12 = pd.read_csv(args.input_fy12, **read_csv_opts)
    logging.info(f'Input file: {args.input_fy12}')
    logging.info(f'Rows in: {len(input_fy12)}')
    input_fy13 = pd.read_csv(args.input_fy13, **read_csv_opts)
    logging.info(f'Input file: {args.input_fy13}')
    logging.info(f'Rows in: {len(input_fy13)}')
    input_fy14 = pd.read_csv(args.input_fy14, **read_csv_opts)
    logging.info(f'Input file: {args.input_fy14}')
    logging.info(f'Rows in: {len(input_fy14)}')
    input_fy15 = pd.read_csv(args.input_fy15, **read_csv_opts)
    logging.info(f'Input file: {args.input_fy15}')
    logging.info(f'Rows in: {len(input_fy15)}')
    input_fy16 = pd.read_csv(args.input_fy16, **read_csv_opts)
    logging.info(f'Input file: {args.input_fy16}')
    logging.info(f'Rows in: {len(input_fy16)}')
    input_fy17 = pd.read_csv(args.input_fy17, **read_csv_opts)
    logging.info(f'Input file: {args.input_fy17}')
    logging.info(f'Rows in: {len(input_fy17)}')
    input_fy18 = pd.read_csv(args.input_fy18, **read_csv_opts)
    logging.info(f'Input file: {args.input_fy18}')
    logging.info(f'Rows in: {len(input_fy18)}')
    input_fy19 = pd.read_csv(args.input_fy19, **read_csv_opts)
    logging.info(f'Input file: {args.input_fy19}')
    logging.info(f'Rows in: {len(input_fy19)}')
    input_fy20 = pd.read_csv(args.input_fy20, **read_csv_opts)
    logging.info(f'Input file: {args.input_fy20}')
    logging.info(f'Rows in: {len(input_fy20)}')
    input_fy21 = pd.read_csv(args.input_fy21, **read_csv_opts)
    logging.info(f'Input file: {args.input_fy21}')
    logging.info(f'Rows in: {len(input_fy21)}')
    input_fy22 = pd.read_csv(args.input_fy22, **read_csv_opts)
    logging.info(f'Input file: {args.input_fy22}')
    logging.info(f'Rows in: {len(input_fy22)}')
    input_fy23 = pd.read_csv(args.input_fy23, **read_csv_opts)
    logging.info(f'Input file: {args.input_fy23}')
    logging.info(f'Rows in: {len(input_fy23)}')

    files = [input_fy12,
             input_fy13,
             input_fy14,
             input_fy15,
             input_fy16,
             input_fy17,
             input_fy18,
             input_fy19,
             input_fy20,
             input_fy21,
             input_fy22,
             input_fy23]

    df = pd.concat(files, sort=False)

    df.columns = df.columns.str.lower()
    df.columns = df.columns.str.replace(' ', '_')    

    df['id'] = range(len(df))
    hash_fields = df.columns
    df['hashid'] = df.apply(make_hashid, axis=1)
    assert len(df['hashid']) == len(set(df['hashid']))
    del hash_fields

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
