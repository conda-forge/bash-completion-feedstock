#!/bin/bash

set -ex

# Replace /opt/anaconda1... with the prefix
# use , instead of / to allow the / in the PATH
sed -i.bak "s,/opt/anaconda1anaconda2anaconda3,${PREFIX},g" bash_completion

autoreconf -i
./configure --prefix=$PREFIX
make
make install

# Copy the [de]activate scripts to $PREFIX/etc/conda/[de]activate.d.
# This will allow them to be run on environment activation.
for CHANGE in "activate" "deactivate"
do
    mkdir -p "${PREFIX}/etc/conda/${CHANGE}.d"
    cp "${RECIPE_DIR}/${CHANGE}.sh" "${PREFIX}/etc/conda/${CHANGE}.d/${PKG_NAME}_${CHANGE}.sh"
done
