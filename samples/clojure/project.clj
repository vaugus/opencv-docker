(defproject clojure-sample "0.1.0-SNAPSHOT"
  :dependencies [[org.clojure/clojure "1.10.3"]
                 [opencv/opencv "4.6.0"]]
  :main clojure-sample.core
  :jvm-opts ["-Djava.library.path=/usr/local/opencv/build/lib/"]
  :injections [(clojure.lang.RT/loadLibrary org.opencv.core.Core/NATIVE_LIBRARY_NAME)]
  :profiles {:uberjar {:aot :all}})
