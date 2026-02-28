#!/usr/bin/env bash

[ "$1" = @selection ] && set -- .
xdg-open "$1"
