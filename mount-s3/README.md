## Directory description

### File `deps.yaml`

Contains the `sources`, `architectures` and `packages` that will be installed as layers in our base image. 
It is used by `MODULE.bazel`'s `apt.install` command.

By configuration definition, we support both `arm` and `amd` architecture, however, later on, we will see that we 
exclude `arm` (for the sake of simplicity).

The libraries that we install are:

- `coreutils` - enables core operations, such as `mkdir`
- `dash` - enables `sh` command inside the image
- `libfuse` - core library that `s3-mount` needs

Note that `mount-s3` can not be installed through `apt`, as it does not belong to a Debian package. Instead, 
we install it from an AWS url, as described below.

### File `aarch64.bzl`

Downloads and extracts `mount-s3` from AWS's package `.tar.gz`. This module is exposed as an extension which is 
used in our `MODULE.bazel`.




