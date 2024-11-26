#!/bin/zsh

if [ -x "$(command -v swiftlint)" ]; then
    swiftlint lint --strict
else
    echo "Install Swiftlint to run linting..."
fi

swift test -c release --parallel
