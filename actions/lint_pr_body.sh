#! /bin/bash

set -xu

git diff origin/$GITHUB_BASE_REF HEAD --name-only --diff-filter=AM | grep -v $TARGET_FILES_PATTERN

if $?; then
  echo "no target files!"
  exit 0
fi

echo "$PULL_REQUEST_BODY" | tr -d '\r\n' | grep $VALID_PATTERN

if $?; then
  echo "valid pull request body!"
  exit 0
fi

echo "invalid_body=true" >> $GITHUB_ENV
exit 0
