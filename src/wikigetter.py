#!/usr/bin/env python
"""
Wikigetter A bare-minimal summary getter for wikipedia.
"""

import unicodedata

__author__ = "Alessandro Paganelli"
__version__ = "0.0.1"
__license__ = "MIT"

import wikipedia
import argparse

def get_summary(topic: str) -> str:
    summary = ""
    results = wikipedia.search(topic)

    if results:
        summary = wikipedia.summary(results[0])

    return summary

def main():
    """Main entry point"""
    parser = argparse.ArgumentParser(description='Gets a summary from wikipedia.')
    parser.add_argument('topic', metavar='t', type=str, help='The topic to search on wikipedia.')
    parser.add_argument('outfile', metavar='o', type=str, help='The output file to dump the summary to')
    args = parser.parse_args()

    wikipedia.set_lang('it')

    topic = args.topic
    print('Getting a summary for: {t}'.format(t=topic))
    summary = get_summary(topic).encode('ascii', 'ignore').decode()

    outfile = args.outfile
    print('Dumping summary to file: {f}'.format(f=outfile))
    with open(outfile, 'w') as f:
        f.write(summary)

    print('Done!')

if __name__ == '__main__':
    """Entry point from the commandline"""
    main()

