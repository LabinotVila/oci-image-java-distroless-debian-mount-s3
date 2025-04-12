## Directory description

### File `bootstrap.sh`

A shell script mounted in the OCI image `entrypoint`. For the sake simplicity and demonstration, we will only
run `mount-s3 --help` command, however, steps for actual mounting are included.

### File `BUILD`

Contains all the targets and layers to build the desired OCI image.

#### Targets to build the `pkg`

- `:runner` - creates a Java library
- `:bin` - creates a Java binary
- `:pkg` - creates a packaged tar

#### Layers

- `:mount_s3_aarch` - copies `mount-s3` binary inside the image at path `/app/mount_s3/aarch64`
- `:bootstrap_tar` - copies the shell script inside the image at path `/app/bootstrap.sh`
- `:flat_apt_deps` - flattens the packages as one layer, used by the OCI image

#### OCI image

- `@java_21_debian_12_amd` is specified as base image (`distroless` from `Google`)
- `"PATH": "$PATH:/app/mount_s3/aarch64"` is used to make `mount-s3` accessible anywhere in the image
- Contains the `bootstrap`, `mount-s3` and `flattened` layers
- `/app/bootstrap.sh` is specified as entrypoint
- `java run` command is specified to run once `bootstrap.sh` is done
