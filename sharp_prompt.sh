#!/bin/bash

cd "$(dirname "$0")"
. ./common.sh

prompt_username

client_prompt | sed 's/^\(.*\)$/#\1/g'
