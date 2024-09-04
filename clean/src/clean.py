#
# :date: 2019-12-26
# :author: PN
# :copyright: GPL v2 or later
#
# ice-enforce/clean/src/clean.py
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
    parser.add_argument("--cleanrules", required=True)
    parser.add_argument("--input", required=True)
    parser.add_argument("--log", required=True)
    parser.add_argument("--output", required=True)
    return parser.parse_args()

if __name__ == "__main__":

    args = _get_args()

    logging.basicConfig(filename=args.log,
                    filemode='w',
                    format=f'%(asctime)s|%(message)s',
                    datefmt='%Y-%m-%d %H:%M:%S',
                    level=logging.INFO)

    logging.info('Log Start Time')

    with open(args.dtypes, 'r') as yamlfile:
        dtypes = yaml.safe_load(yamlfile)

    read_csv_opts = {'sep': '|',
                     'quotechar': '"',
                     'compression': 'gzip',
                     'encoding': 'utf-8'}

    df = pd.read_csv(args.input, **read_csv_opts, dtype=dtypes)

    logging.info(f'Input file: {args.input}')
    logging.info(f'Rows in: {len(df)}')

    with open(args.cleanrules, 'r') as yamlfile:
        cleanrules = yaml.safe_load(yamlfile)

    df = df.rename({'area_of_responsibility': 'aor'}, axis=1)
    df = df.rename({'event_area_of_responsibility': 'aor'}, axis=1)
    df['area_of_responsibility'] = df['aor']
    df['aor'] = df['aor'].str.replace('Area of Responsibility', '')

    for k in cleanrules.keys():
        df[k] = df[k].str.strip().replace(cleanrules[k])

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
