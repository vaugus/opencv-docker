cd `mktemp -d`
wget https://raw.github.com/technomancy/leiningen/stable/bin/lein
chmod +x lein
mv lein /usr/local/bin/
lein help
lein --version
cd -