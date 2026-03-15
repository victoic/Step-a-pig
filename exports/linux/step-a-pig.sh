#!/bin/sh
printf '\033c\033]0;%s\a' Step-a-Pig
base_path="$(dirname "$(realpath "$0")")"
"$base_path/step-a-pig.x86_64" "$@"
