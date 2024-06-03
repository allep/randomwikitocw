#!/bin/bash

OUTFILE=$1

# Settings
WPM=17
SNR=10

# Available: 100, 500, 1000, 2100
BANDWIDTH=500

# Internals
TOPIC=""
TEMP_FILE=""
ACTIVATE="/home/alle/workspace/venv/ebook/bin/activate"

# Functions
get_random_topic() {
    echo "Getting random topic ..."
    TOPIC=$(wget -O - https://it.wikipedia.org/wiki/Speciale:PaginaCasuale | grep '<title>' | awk -F"[>-]" '{print $2}')
    echo "Found topic: $TOPIC"
}

retrieve_content_from_wikipedia() {
    echo "Retrieving $TOPIC ..."
    source "$ACTIVATE"
    # FIXME: determine wikigetter path dynamically
    python src/wikigetter.py "$TOPIC" "$TEMP_FILE"
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

