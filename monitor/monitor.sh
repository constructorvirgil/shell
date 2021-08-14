#!/bin/bash

#description: if the specified file size is greater than SIZE, then adjust file size to SIZE/2
#arg1: filepath
#arg2: size(bytes)
function adjustFile {
    echo "arg1=$1"
    echo "arg2=$2"
    size=$(du -b $1 | awk '{print $1}') || return
    want_size=$(echo "$2/2" | bc) || return
    echo "size=$size"
    echo "want_size=$want_size"

    if [[ $size -gt $2 ]]; then
        tail -c $want_size $1 > /tmp/tmpfile || return
        mv /tmp/tmpfile $1 || return
        echo "adjust file size to $want_size"
        return
    fi
    echo "file no change"
}
