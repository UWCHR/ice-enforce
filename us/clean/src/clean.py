#
# :date: 2019-12-26
# :author: PN
# :copyright: GPL v2 or later
#
# ice-ero-lesa/us/clean/src/clean.py
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
    parser.add_argument("--cleanrules", required=True)
    parser.add_argument("--input", required=True)
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
                     'encoding': 'utf-8'}

    df = pd.read_csv(args.input, **read_csv_opts, dtype=dtypes)

    with open(args.cleanrules, 'r') as yamlfile:
        cleanrules = yaml.load(yamlfile)

    redacted = ['birth_date']
    df = df.drop(redacted, axis=1)
    df = df.rename({'area_of_responsibility': 'aor'}, axis=1)
    df = df.rename({'event_area_of_responsibility': 'aor'}, axis=1)
    df['aor'] = df['aor'].str.replace('Area of Responsibility', '')

    for k in cleanrules.keys():
        df[k] = df[k].str.strip().replace(cleanrules[k])

    write_csv_opts = {'sep': '|',
                      'quotechar': '"',
                      'compression': 'gzip',
                      'encoding': 'utf-8',
                      'index': False}

    df.to_csv(args.output, **write_csv_opts)
    print(f'Wrote {len(df)} records to {args.output}')

# END.
