#!/bin/bash

TOPIC=$1
OUTFILE=$2

# Internals
ACTIVATE="/home/alle/workspace/venv/ebook/bin/activate"

echo "Retrieving topic $TOPIC and converting to CW to $OUTFILE"

temp_file=$(mktemp)

echo "Retrieving topic ..."
source "$ACTIVATE"
python wikigetter.py "$TOPIC" "$temp_file"

echo "Converting to cw ..."
ebook2cw -w 17 -N 10 -o "$TOPIC.mp3" "$temp_file"

deactivate

