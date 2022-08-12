(ns clojure-sample.core
  (:import [org.opencv.core Core CvType Mat])
  (:gen-class))

(defn -main [& args]
  (println "Welcome to OpenCV" Core/VERSION)
  (println "Library name:" Core/NATIVE_LIBRARY_NAME)
  ;; (let [mat (. Mat zeros 5 5 CvType/CV_8UC1)]
  ;;   (println (.dump mat)))
  (println "Hello, World!"))
