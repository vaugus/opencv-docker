FROM alpine:3.15

ARG OPENCV_VERSION=4.6.0
ARG OPENCV_HOME=/home/opencv
ARG OPENCV_PATH=/usr/local/opencv
ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk/
ENV OPENCV_JAVA_BINARY_PATH=${OPENCV_PATH}/build/bin/
ENV OPENCV_JAVA_LIBRARY_PATH=${OPENCV_PATH}/build/lib/

COPY ./scripts/ $OPENCV_HOME
COPY ./samples/ $OPENCV_HOME

RUN addgroup -S opencv && adduser -S opencv -G opencv

RUN cd $OPENCV_HOME && sh dependencies.sh \
    && sh setup-lein.sh \
    && bash -c hash -r \
    && bash setup-opencv.sh ${OPENCV_VERSION} \
    && chown -R opencv $OPENCV_HOME \
    && chmod +x $OPENCV_HOME/health-check

USER opencv

WORKDIR /work
