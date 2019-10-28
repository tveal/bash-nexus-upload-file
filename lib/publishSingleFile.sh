##################################################################################
# This file is NOT meant to be run directly, rather, source it in another script #
##################################################################################

# help set:
# -e  Exit immediately if a command exits with a non-zero status.
#
# Intend script to exit on any failure so following steps are not executed.
set -e

function main() {
    validateProps
    getNexusServer
    getSemVer
    publish
}

function getNexusServer() {
    echo "--Nexus Server--"
    read -p "Use remote? [Y/n]: " REMOTE_NEXUS
    case "$REMOTE_NEXUS" in
        y|Y|[yY][eE][sS] )
            echo "using REAL nexus with base url:"
            echo "NEXUS_REPO_URL=$NEXUS_REPO_URL"
            NEXUS_SERVER="$NEXUS_REPO_URL"
            getNexusCreds
            setupNexusSettingsXml
            ;;
        * )
            NEXUS_SERVER="file:///tmp/nexus-local"
            echo "using local nexus:"
            echo "NEXUS_SERVER=$NEXUS_SERVER"
            ;;
    esac
    echo
}

function getNexusCreds() {
    echo "--Need to get credentials for Nexus push--"
    read -p "Username: " NEXUS_USR
    read -sp "Password [hidden]: " NEXUS_PWD
    echo
}

function setupNexusSettingsXml() {
    mkdir -p ~/.m2
    local settingsFile=~/.m2/settings.xml
    test -f "$settingsFile" || touch "$settingsFile"
    # remove existing scripted settings https://stackoverflow.com/a/6287940
    sed -i '/scripted-nexus-start/,/scripted-nexus-end/d' "$settingsFile"
    cat "$THIS_DIR/lib/settings.xml" >> "$settingsFile"
}

function getSemVer() {
    echo "--Version to publish for [$GROUP_ID:$ARTIFACT_ID]--"
    read -p "SemVer [x.y.z]: " SEMVER
    echo "SEMVER=$SEMVER"
    echo
}

function publish() {
    mvn deploy:deploy-file \
        -DgroupId="$GROUP_ID" \
        -DartifactId="$ARTIFACT_ID" \
        -Dversion="$SEMVER" \
        -DgeneratePom=true \
        -Dpackaging="$MVN_PACKAGING" \
        -DrepositoryId=scripted-nexus \
        -Durl="$NEXUS_SERVER" \
        -Dfile="$FILE_DIR/$FILE_NAME" \
        -Drepo.usr="$NEXUS_USR" \
        -Drepo.pwd="$NEXUS_PWD"
}

function validateProps() {
    validateProp "FILE_DIR" "$FILE_DIR" "~/Downloads/SomeFolder"
    validateProp "FILE_NAME" "$FILE_NAME" "\"MyCustomArtifacts.zip\""
    validateProp "MVN_PACKAGING" "$MVN_PACKAGING" "\"zip\" (other examples: pom, jar, maven-plugin, ejb, war, ear, rar)"
    validateProp "GROUP_ID" "$GROUP_ID" "\"org.mybiz.feature\""
    validateProp "ARTIFACT_ID" "$ARTIFACT_ID" "\"really-cool-tool\""
    validateProp "NEXUS_REPO_URL" "$NEXUS_REPO_URL" "\"https://nexus.mybiz.org/content/repositories/my-repo\""
}

function validateProp() {
    if [ -z "$2" ]; then
        echo "Must set the $1 variable"
        if [ ! -z "$3" ]; then
            echo "Example: $1=$3"
        fi
        echo
        exit 1
    fi
}

main "$@"
