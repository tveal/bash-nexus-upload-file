#!/bin/bash
THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

FILE_DIR=/tmp
FILE_NAME="MyCustomArtifact.jar"
MVN_PACKAGING="jar"

GROUP_ID="org.mybiz.feature"
ARTIFACT_ID="my-custom-jar"
NEXUS_BASE_URL="nexus.mybiz.org/content/repositories/my-repo"

source $THIS_DIR/lib/publishSingleFile.sh