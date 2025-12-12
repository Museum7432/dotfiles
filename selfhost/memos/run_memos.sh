#!/bin/bash

export MEMOS_MODE=prod
export MEMOS_PORT=5229
export MEMOS_DATA=$PWD/data
# export MEMOS_ADDR=localhost
MEMOS_DRIVER=sqlite

/usr/bin/memos
