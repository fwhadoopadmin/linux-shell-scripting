# script simply check all installed python packages
# it also generate template called installPythonPkgs.txt
# u can use this to compare it with another installs on another node  or just to know what is   installed
###########################################################################################################


#!/bin/bash

pipfile=$(echo "$(which pip)")
#/opt/anaconda/bin/pip

echo ""  && \

if [[ `$echo $pipfile |wc -l` -ge 1 ]]; then
        echo "Found pip ---generating installed python libraries templatefiles";
        $pipfile freeze > installPythonPkgs.txt
        sleep 2;
        echo "Done & Good!"
        exit 0
else
        echo "Sorry Unable to locate pip file: Run pip freeze manually";
fi

