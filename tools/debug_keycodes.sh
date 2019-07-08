#!/bin/sh

log stream | sed -n 's/.*\(ApplePS2Keyboard: sending key\)/\1/p'

