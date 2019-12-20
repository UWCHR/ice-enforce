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


def mem_usage(pandas_obj):
    if isinstance(pandas_obj, pd.DataFrame):
        usage_b = pandas_obj.memory_usage(deep=True).sum()
    else:  # we assume if not a df it's a series
        usage_b = pandas_obj.memory_usage(deep=True)
    usage_mb = usage_b / 1024 ** 2  # convert bytes to megabytes
    return "{:03.2f} MB".format(usage_mb)


if __name__ == "__main__":

    args = _get_args()

    with open(args.dtypes, 'r') as yamlfile:
        dtypes = yaml.load(yamlfile)

    read_csv_opts = {'sep': '|',
                     'quotechar': '"',
                     'compression': 'gzip',
                     'encoding': 'utf-8',
                     'header': 5}

    input_fy16 = pd.read_csv(args.input_fy16, **read_csv_opts, dtype=dtypes)
    input_fy17 = pd.read_csv(args.input_fy17, **read_csv_opts, dtype=dtypes)
    input_fy18 = pd.read_csv(args.input_fy18, **read_csv_opts, dtype=dtypes)
    input_fy19 = pd.read_csv(args.input_fy19, **read_csv_opts, dtype=dtypes)

    files = [input_fy16,
             input_fy17,
             input_fy18,
             input_fy19]

    df = pd.concat(files, sort=False)

    write_csv_opts = {'sep': '|',
                      'quotechar': '"',
                      'compression': 'gzip',
                      'encoding': 'utf-8',
                      'index': False}

    df.to_csv(args.output, **write_csv_opts)

# END.
