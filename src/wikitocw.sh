#!/bin/bash

OUTFILE=$1

# Settings
WPM=18
SNR=13

# Available: 100, 500, 1000, 2100
BANDWIDTH=500

# Internals
TOPIC=""
TEMP_FILE=""
ACTIVATE="$HOME/workspace/venv/ebook/bin/activate"
THIS_DIR=$(pwd)
WIKIGETTER=$(find . -name wikigetter.py)

# Functions
get_random_topic() {
    echo "Getting random topic ..."
    TOPIC=$(wget -O - https://it.wikipedia.org/wiki/Speciale:PaginaCasuale | grep '<title>' | awk -F"[>-]" '{print $2}')
    echo "Found topic: $TOPIC"
}

retrieve_content_from_wikipedia() {
    echo "Retrieving $TOPIC to $TEMP_FILE"
    source $ACTIVATE
    python "$WIKIGETTER" "$TOPIC" "$TEMP_FILE"
    deactivate
}

convert_to_cw() {
    echo "Converting to cw ..."
    ebook2cw -w "$WPM" -N "$SNR" -B "$BANDWIDTH" -o "$OUTFILE" "$TEMP_FILE"
}

# Actual script
#

echo "Retrieving random topic and converting to CW to $OUTFILE"

get_random_topic

TEMP_FILE=$(mktemp)

retrieve_content_from_wikipedia
convert_to_cw

echo "Done!"

