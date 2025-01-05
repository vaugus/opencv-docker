(ns clojure-sample.core-test
  (:require [clojure.test :refer :all]
            [clojure-sample.core :refer :all])
  (:import [org.opencv.core Core CvType Mat]))

(deftest opencv-loading-test
  (testing "Loaded OpenCV library is the image's version one."
    (is (= Core/VERSION (. System getenv "OPENCV_VERSION"))))
    
  (testing "Simple operations with the Mat object."
    (let [zeros (. Mat zeros 5 5 CvType/CV_8UC1)
          ones  (. Mat ones 5 5 CvType/CV_8UC1)]
      (is (not (.empty zeros)))
      (is (not (.empty ones))))))
