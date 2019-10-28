# Upload a Single file to a Nexus Maven Repo

Just a simple collection of bash scripts to empower you to upload a single file to
a Nexus server.

## Requirements

- **Bash shell**; Standard terminal session on modern Linux distros
- **Maven (mvn)**; On Ubuntu, you can install with:
    ```bash
    sudo apt install maven
    ```

---

NOTE: remote server option is configured to prompt you for your user/password to
use in the final Nexus url. You should check the implementation for your security
needs. See [lib/publishSingleFile.sh](lib/publishSingleFile.sh)

---

## Try it out

1. Create a dummy zip file to upload

    ```bash
    touch /tmp/MyCustomArtifacts.zip
    ```
2. From this directory, run the [publishZip.sh](publishZip.sh) script (from a terminal)

    ```bash
    ./publishZip.sh
    ```
3. Follow the prompts, not accepting remote nexus server.

    ```
    you@ubuntu:~/repos/github/bash-nexus-upload-file$ ./publishZip.sh 
    --Nexus Server--
    Use remote? [Y/n]: n
    using local nexus:
    NEXUS_SERVER=file:///tmp/nexus-local

    --Version to publish for [org.mybiz.feature:really-cool-tool]--
    SemVer [x.y.z]: 1.2.3
    SEMVER=1.2.3

    [INFO] Scanning for projects...
    [INFO] 
    [INFO] ------------------< org.apache.maven:standalone-pom >-------------------
    [INFO] Building Maven Stub Project (No POM) 1
    [INFO] --------------------------------[ pom ]---------------------------------
    [INFO] 
    [INFO] --- maven-deploy-plugin:2.7:deploy-file (default-cli) @ standalone-pom ---
    Uploading to nexus: file:///tmp/nexus-local/org/mybiz/feature/really-cool-tool/1.2.3/really-cool-tool-1.2.3.zip
    Uploaded to nexus: file:///tmp/nexus-local/org/mybiz/feature/really-cool-tool/1.2.3/really-cool-tool-1.2.3.zip (0 B at 0 B/s)
    Uploading to nexus: file:///tmp/nexus-local/org/mybiz/feature/really-cool-tool/1.2.3/really-cool-tool-1.2.3.pom
    Uploaded to nexus: file:///tmp/nexus-local/org/mybiz/feature/really-cool-tool/1.2.3/really-cool-tool-1.2.3.pom (435 B at 435 kB/s)
    Downloading from nexus: file:///tmp/nexus-local/org/mybiz/feature/really-cool-tool/maven-metadata.xml
    Uploading to nexus: file:///tmp/nexus-local/org/mybiz/feature/really-cool-tool/maven-metadata.xml
    Uploaded to nexus: file:///tmp/nexus-local/org/mybiz/feature/really-cool-tool/maven-metadata.xml (313 B at 313 kB/s)
    [INFO] ------------------------------------------------------------------------
    [INFO] BUILD SUCCESS
    [INFO] ------------------------------------------------------------------------
    [INFO] Total time:  0.852 s
    [INFO] Finished at: 2019-10-26T20:05:13-05:00
    [INFO] ------------------------------------------------------------------------
    ```
