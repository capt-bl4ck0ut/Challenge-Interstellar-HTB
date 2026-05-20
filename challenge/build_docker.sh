#!/bin/bash
docker build --tag=web-interstellar . && \
docker run -p 1337:80 --rm --name=web-interstellar -it web-interstellar