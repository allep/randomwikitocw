#!/usr/bin/env python
"""
Wikigetter A bare-minimal summary getter for wikipedia.
"""

__author__ = "Alessandro Paganelli"
__version__ = "0.0.1"
__license__ = "MIT"

import wikipedia
import argparse

def main():
    """Main entry point"""
    parser = argparse.ArgumentParser(description='Gets a summary from wikipedia.')
    parser.add_argument('topic', metavar='t', type=str, help='The topic to search on wikipedia.')
    args = parser.parse_args()
    print(args.topic)

if __name__ == "__main__":
    """Entry point from the commandline"""
    main()

