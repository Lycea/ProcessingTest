#!/bin/bash

if [ -z "$(which inotifywait)" ]; then
    echo "inotifywait not installed."
    echo "In most distros, it is available in the inotify-tools package."
    exit 1
fi

counter=0;

function execute() {
    counter=$((counter+1))
    echo $counter
    bash start_gen.sh 
    eval "$@"
}


inotifywait --recursive --monitor --format "%e %w%f" \
            --event modify \
            --exclude .git/ \
            --exclude .venv/ \
            --exclude content/ \
            --exclude generated/ \
            ./ \
    | while read changed; do
    echo $changed
    execute "$@"
done

