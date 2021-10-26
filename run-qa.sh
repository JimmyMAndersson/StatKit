if [ -x "$(command -v docker)" ]; then
    docker-compose -f docker-qa.yml run linux-tests
    docker-compose -f docker-qa.yml run linter
else
    echo "Install Docker to run Linux tests and linting..."
fi

xcodebuild -scheme StatKit -destination 'platform=macOS' -configuration release -quiet build test
