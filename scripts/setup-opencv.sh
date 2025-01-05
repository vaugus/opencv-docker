#!/bin/bash

opencv_tmp_directory='/usr/local/opencv'

download_opencv() {
  local opencv_version="$1"

  wget -q -O $opencv_tmp_directory/opencv.zip "https://github.com/opencv/opencv/archive/$opencv_version.zip"
  unzip -q $opencv_tmp_directory/opencv.zip 
}

build_opencv() {
  local opencv_version="$1"

  mkdir -p $opencv_tmp_directory && mkdir -p $opencv_tmp_directory/build
  cd $opencv_tmp_directory

  download_opencv "$opencv_version" "$opencv_tmp_directory"
  cd $opencv_tmp_directory/build

  cmake -DBUILD_TESTS=OFF \
        -DBUILD_opencv_java=ON \
        -DBUILD_SHARED_LIBS=ON \
        -DBUILD_opencv_python2=OFF \
        -DBUILD_opencv_python3=OFF \
        ../opencv-4.6.0/ 

  make -j$(nproc)
  make install
}

copy_opencv_binaries() {
  local opencv_version="$1"

  cd $opencv_tmp_directory
  cp -r build/bin/ . && cp -r build/lib/ .
  rm -rf build
  mkdir build && cp -r ./bin build/ && cp -r ./lib build/
  rm -rf bin/ && rm -rf lib/

  rm -rf opencv-$opencv_version
  rm -f opencv.zip
}

setup_clojure_environment() {
  local opencv_version="$1"

  jar_version="${opencv_version//./""}"

  opencv_build_folder=$opencv_tmp_directory/build
  native_folder=$opencv_build_folder/native/linux/x86_64/

  mkdir -p $opencv_build_folder/clj-opencv && cd $opencv_build_folder/clj-opencv
  cp $opencv_build_folder/bin/opencv-$jar_version.jar .

  mkdir -p ~/.lein
  cd ~/.lein
  echo "{:user {:plugins [[lein-localrepo \"0.5.2\"]]}}" > profiles.clj

  cd $opencv_build_folder/clj-opencv
  lein localrepo install opencv-$jar_version.jar opencv/opencv $opencv_version
}

main() {
  local opencv_version="$1"

  build_opencv "$opencv_version"
  copy_opencv_binaries "$opencv_version"
  setup_clojure_environment
}

main "$@"