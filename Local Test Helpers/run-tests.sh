if [ -x "$(command -v docker)" ]; then
    docker-compose -f docker-qa.yml up
else
    echo "Install Docker to run Linux tests and linting..."
fi

swift test -c release --parallel
