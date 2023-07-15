#!/bin/bash

while getopts "hvf:" opt; do
    case $opt in
        h)
            echo "Usage: script.sh [-h] [-v] [-f file]"
            exit 0
            ;;
        v)
            echo "Verbose mode on"
            ;;
        f)
            echo "File: $OPTARG"
            ;;
        *)
            echo "Unknown option: -$opt"
            exit 1
            ;;
    esac
done

shift $((OPTIND-1))

echo "Non-option arguments:"
for arg in "$@"; do
    echo "  $arg"
done
