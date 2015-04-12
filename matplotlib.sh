#!/bin/bash

function add {
    cat $1 >> matplotlib.tex
}

if [ -f matplotlib.tex ]; then
    rm matplotlib.tex
fi
touch matplotlib.tex

add "base/packages.tex"
add "base/lua.tex"
add "math/packages.tex"
add "math/common.tex"
add "math/complex.tex"
add "math/differential.tex"
add "math/functions-common.tex"
add "math/functions-special.tex"
add "math/functions-trigonometric.tex"
add "math/matrices.tex"
add "math/vectors.tex"
add "physics/packages.tex"
add "physics/units.tex"
