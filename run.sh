#!/bin/bash

set -e

THIS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" > /dev/null 2>&1 && pwd )"

function load_dotenv {
    while read -r line; do
            export "$line"
    done < <(grep -v '^#' "$THIS_DIR/.env" | grep -v '^$')
}

function install {
    python -m pip install --upgrade pip
    python -m pip install --editable "$THIS_DIR/[dev]"
}

function lint {
    pre-commit run --all-files
}
function build {
    python -m build --sdist --wheel "$THIS_DIR/"

}

function clean {
    rm -rf "$THIS_DIR/dist"
    rm -rf "$THIS_DIR/build"
    rm -rf "$THIS_DIR/*.egg-info"
}

function release:test {
    clean
    build
    publish:test
}

function release:prod {
    release:test
    publish:prod
}

function publish:test {
    load_dotenv
    twine upload dist/* \
        --repository testpypi \
        --username=__token__ \
        --password="$TEST_PYPI_TOKEN"
}

function publish:prod {
    load_dotenv
    twine upload dist/* \
        --repository pypi \
        --username=__token__ \
        --password="$PROD_PYPI_TOKEN"
}
# function start {
#     echo "start task not implemented"
# }

# function default {
#     start
# }

function help {
    echo "$0 <task> <args>"
    echo "Tasks:"
    compgen -A function | cat -n
}

TIMEFORMAT="Task completed in %3lR"
time ${@:-help}
