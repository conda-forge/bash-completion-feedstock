#!/bin/bash

set -ex

# Check for recent enough version of bash.
# This is the same check used in the integration script
if [ ${BASH_VERSINFO[0]} -gt 4 ] || \
    [ ${BASH_VERSINFO[0]} -eq 4 -a ${BASH_VERSINFO[1]} -ge 1 ]; then

    # The docker image has a stray completion file
    # (/etc/bash_completion.d/yum-utils.bash), pretend we have yum
    # completion installed.
    echo 'true' > $PREFIX/bin/_yum

    # Ensure the library loads without error at least
    bash -e bash_completion

    rm $PREFIX/bin/_yum
fi
