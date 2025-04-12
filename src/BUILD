load("@rules_java//java:defs.bzl", "java_binary")
load("@rules_pkg//:pkg.bzl", "pkg_tar")
load("@rules_oci//oci:defs.bzl", "oci_image", "oci_push", "oci_tarball")
load("@rules_distroless//distroless:defs.bzl", "flatten")

package(default_visibility = ["//visibility:public"])

# Creating a Java library, a binary and a packaged tar
java_library(
    name = "runner",
    srcs = glob(["*.java"]),
    visibility = ["//visibility:public"],
)
java_binary(
    name = "bin",
    runtime_deps = [
        ":runner",
    ],
    main_class = "src.Runner",
)
pkg_tar(
    name = "pkg",
    srcs = [":bin_deploy.jar"],
    strip_prefix = ".",
    visibility = ["//visibility:public"],
)

# Moving over from AWS the mount-s3 package
pkg_tar(
    name = "mount_s3_aarch",
    srcs = ["@mount_s3_aarch64_repo//:bin_files"],
    package_dir = "/app/mount_s3/aarch64",
    extension = "tar"
)
# Bootstrap script that will run as entrypoint (in this case, only mount-s3 --help will run)
pkg_tar(
    name = "bootstrap_tar",
    srcs = ["bootstrap.sh"],
    mode = "0755",
    package_dir = "/app",
)

# We specify packages that we want to include as layers
PACKAGES = [
    "@mount_s3_dependencies//coreutils",
    "@mount_s3_dependencies//dash",
    "@mount_s3_dependencies//libfuse2",
]
flatten(
    name = "flat_apt_deps",
    deduplicate = True,
    tars = select({
        "@platforms//cpu:arm64": ["%s/arm64" % package for package in PACKAGES],
        "@platforms//cpu:x86_64": [] # we can skip this since we are only using ARM architecture
    })
)

# We create an image
oci_image(
    name = "oci-image",
    base = "@java_21_debian_12_amd",
    env = {
        # make available mount-s3 command by including it in the $PATH
        "PATH": "$PATH:/app/mount_s3/aarch64",
    },
    tars = [
        ":pkg", # this is the application
        ":bootstrap_tar", # this is the bootstrap script
        ":flat_apt_deps", # this are the dependencies we have installed with apt
        ":mount_s3_aarch" # this is the mount-s3 binary
    ],
    entrypoint = [
        "/app/bootstrap.sh" # we first run the boostrap script
    ],
    cmd = [
        "java", "-Xmx3000m", "-jar", "/bin_deploy.jar", # the command that runs at the end of boostrap
    ],
    visibility = ["//visibility:public"],
)

# We wrap the image in an OCI format
oci_tarball(
    name = "image-tarball",
    image = ":oci-image",
    repo_tags = ["image:1"],
    visibility = ["//visibility:public"],
)
