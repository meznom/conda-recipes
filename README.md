# Conda recipes

## Overview

The repository contains [conda]() recipes for some of my Python projects and
their dependencies, specifically for [coma]() and [qca](). The recipes only
target OS X and Linux for now, Windows is not supported. Binary packages for
OS X and Linux are available on [Binstar](). The packages are built on OS X 10.9
and Ubuntu 14.04.

## Building the conda packages

The packages can be build by running:
```
$ conda build coma boost-headers boost-python boost-test eigen qca
```

## Using the conda packages

Once built, the packages can be installed with:
```
$ conda install \
        --use-local \
        coma boost-headers boost-python boost-test eigen qca
```

Alternatively, and this should be easier, the packages can be installed from
[Binstar]() without previously building them.
```
$ conda install \
        -c https://conda.binstar.org/meznom \
        coma boost-headers boost-python boost-test eigen qca
```

## License

The recipes are distributed under the two-clause BSD license. See the `LICENSE`
file for details.

---
Burkhard Ritter (<burkhard@ualberta.ca>), May 2014


[conda]: https://github.com/conda/conda
[coma]: https://bitbucket.org/meznom/coma
[qca]: https://bitbucket.org/meznom/qca
[Binstar]: https://binstar.org/meznom
