#!/bin/sh

log show --predicate 'process == "kernel"' --last $1m
