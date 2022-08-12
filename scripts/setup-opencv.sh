OPENCV_TMP=/usr/local/opencv

createBuildDirectories() {
  mkdir -p $OPENCV_TMP && mkdir -p $OPENCV_TMP/build
}

downloadOpenCV() {
  OPENCV_VERSION=$1
  wget -q -O $OPENCV_TMP/opencv.zip https://github.com/opencv/opencv/archive/$OPENCV_VERSION.zip
  unzip -q $OPENCV_TMP/opencv.zip 
}

buildOpenCV() {
  OPENCV_VERSION=4.6.0

  createBuildDirectories
  cd $OPENCV_TMP

  downloadOpenCV $OPENCV_VERSION 
  cd $OPENCV_TMP/build

  cmake -DBUILD_TESTS=OFF \
        -DBUILD_opencv_java=ON \
        -DBUILD_SHARED_LIBS=ON \
        -DBUILD_opencv_python2=OFF \
        -DBUILD_opencv_python3=OFF \
        ../opencv-4.6.0/ 

  make -j$(nproc)
  make install
}

setupClojureEnvironment() {
  jarVersion="${OPENCV_VERSION//./""}"

  buildFolder=$OPENCV_TMP/build
  native_folder=$buildFolder/native/linux/x86_64/

  mkdir -p $buildFolder/clj-opencv && cd $buildFolder/clj-opencv
  cp $buildFolder/bin/opencv-$jarVersion.jar .

  mkdir -p ~/.lein
  cd ~/.lein
  echo "{:user {:plugins [[lein-localrepo \"0.5.2\"]]}}" > profiles.clj

  cd $buildFolder/clj-opencv
  lein localrepo install opencv-$jarVersion.jar opencv/opencv $OPENCV_VERSION
}

copyOpenCVBinaries() {
  cd $OPENCV_TMP
  cp -r build/bin/ . && cp -r build/lib/ .
  rm -rf build
  mkdir build && cp -r ./bin build/ && cp -r ./lib build/
  rm -rf bin/ && rm -rf lib/

  rm -rf opencv-$OPENCV_VERSION
  rm -f opencv.zip
}

buildOpenCV
copyOpenCVBinaries
setupClojureEnvironment