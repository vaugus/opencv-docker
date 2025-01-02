REPO=/etc/apk/repositories

echo '@edgemain http://nl.alpinelinux.org/alpine/edge/main' >> $REPO
echo '@edgecomm http://nl.alpinelinux.org/alpine/edge/community' >> $REPO
echo '@edgetest http://nl.alpinelinux.org/alpine/edge/testing' >> $REPO

apk update && \
# apk upgrade && \
apk --no-cache add \
    bash \
    build-base \
    ca-certificates \
    clang-dev \
    clang \
    cmake \
    coreutils \
    curl \
    freetype-dev \
    ffmpeg-dev \
    ffmpeg-libs \
    gcc \
    g++ \
    git \
    gettext \
    lcms2-dev \
    libavc1394-dev \
    libc-dev \
    libffi-dev \
    libjpeg-turbo-dev \
    libpng-dev \
    libressl-dev \
    libtbb@edgetest \
    libtbb-dev@edgetest \
    libwebp-dev \
    linux-headers \
    make \
    musl \
    openblas@edgecomm \
    openblas-dev@edgecomm \
    openjpeg-dev \
    openssl \
    tiff-dev \
    unzip \
    zlib-dev \
    apache-ant \
    openjdk11 \
    glib-dev \
    gtk+2.0-dev \
    openjpeg-tools