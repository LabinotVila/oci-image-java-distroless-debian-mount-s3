def _custom_repo_impl(repository_ctx):
    # For an ARM image, download the tar file from AWS
    repository_ctx.download_and_extract(
        url = "https://s3.amazonaws.com/mountpoint-s3-release/latest/arm64/mount-s3.tar.gz",
        type = ".tar.gz"
    )

    # Create a file group from the downloaded content (we only need data inside /bin folder)
    build_file_content = """
filegroup(
    name = "bin_files",
    srcs = glob(["bin/**/*"]),
    visibility = ["//visibility:public"],
)
"""
    repository_ctx.file("BUILD", build_file_content)

# Repository rule
_mount_s3_aarch64_repo = repository_rule(
    implementation = _custom_repo_impl,
    attrs = {}
)

# Module extension
def _mount_s3_aarch64_ext_impl(module_ctx):
    _mount_s3_aarch64_repo(name = "mount_s3_aarch64_repo")

mount_s3_aarch64_repo = module_extension(
    implementation = _mount_s3_aarch64_ext_impl,
)
