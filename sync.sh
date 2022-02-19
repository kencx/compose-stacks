#!/bin/bash

# synchronizes .env and .env.example file.

# common lines that contain sensitive information
REGEX="^[DOMAIN|CA_EMAIL].*"

ACTUAL_FILE=".env"
EXAMPLE_FILE=".env.example"

diff -uB <(grep -vE $REGEX $EXAMPLE_FILE) <(grep -vE $REGEX $ACTUAL_FILE) > env.patch
patch $EXAMPLE_FILE env.patch
rm env.patch .*.orig
