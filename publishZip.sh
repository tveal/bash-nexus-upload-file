#!/bin/bash
THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

FILE_DIR=/tmp
FILE_NAME="MyCustomArtifacts.zip"
MVN_PACKAGING="zip"

GROUP_ID="org.mybiz.feature"
ARTIFACT_ID="really-cool-tool"
NEXUS_REPO_URL="https://nexus.mybiz.org/content/repositories/my-repo"

source $THIS_DIR/lib/publishSingleFile.sh