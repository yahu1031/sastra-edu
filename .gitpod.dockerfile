############################################################################################
#            DO NOT EDIT THIS DOCKER FILE AND PUSH. THIS IS CUSTOM MADE DOCKER.            #
############################################################################################
FROM gitpod/workspace-full

USER gitpod

# Updating system files.
RUN set -ex; \
    sudo apt-get update; \
    sudo apt-get install -y libglu1-mesa; \
    sudo rm -rf /var/lib/apt/lists/*

# Setting up flutter.
RUN set -ex; \
    mkdir ~/development; \
    cd ~/development; \
    git clone --depth 1 https://github.com/flutter/flutter.git -b stable --no-single-branch

# Adding to path to environment.
ENV PATH="$PATH:/home/gitpod/development/flutter/bin"

# Setting up environment according to the project.
RUN set -ex; \
    flutter channel stable; \
    flutter upgrade; \
    flutter config --enable-windows-desktop; \
    flutter config --enable-macos-desktop; \
    flutter config --enable-linux-desktop; \
    flutter precache; \
    flutter doctor -v
