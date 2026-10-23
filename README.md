# alpine

Small interactive debugging image with Bash, curl, Vim and jq. Supports
`linux/amd64` and `linux/arm64`.

```sh
docker run --rm -it ghcr.io/edwmurph/alpine:0.0.3
```

Bash remains the default command and build shell. To run a command, specify the
executable explicitly, for example `docker run --rm ghcr.io/edwmurph/alpine:0.0.3
/bin/bash -c 'curl --version'`.

## Base and security updates

The 0.0.3 release uses official Alpine 3.24.3, pinned to its multi-platform index
`sha256:be2656061b536c1883c4034790e21d0a09c5aaaf51968b89368a3c0371ea2c9a`.
[Alpine's release table](https://www.alpinelinux.org/releases/) lists v3.24 as
supported through June 1, 2028. This selection was checked October 23, 2026.

The build upgrades base packages and installs the current Bash, curl, Vim and jq
packages from that stable branch. Package repositories can change, so rebuilding
a source commit can produce newer packages. Use the published image digest when
an immutable complete image is required. Update the base version and digest
together during future maintenance, then repeat verification.

The tag-triggered GitHub Actions workflow builds and tests both architectures
before publication. `tests/smoke.sh IMAGE PLATFORM` checks the configured shell,
interactive Bash, tool startup, curl file access, Vim editing and jq processing.
Trivy 0.76.1 scans every reported vulnerability severity using current advisory
data without suppressing unfixed findings. Scan reports are retained as workflow
artifacts. The published images are pulled, tested and scanned again. A scan
failure after publication requires follow-up and does not remove existing tags.

Release by pushing a new `v*` semver tag after checks pass. The existing workflow
publishes the version tag and `latest` to `ghcr.io/edwmurph/alpine`. Verify the
registry index and platform digests, tool/package versions and scan results
before declaring a release complete. Passing scans only establish that no known
findings were reported by the selected scanner and advisory snapshot. They do
not establish absence of vulnerabilities or runtime risk.
