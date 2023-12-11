#!/bin/bash
# CLI for removing LaTeX build file

Version="0.1"
Date="2023/12/07"

# getopt setup
OPTSET=$(getopt -o hyv --long help,yes,version \
              -n 'texclean' -- "$@")

if [ $? != 0 ] ; then echo "Terminating..." >&2 ; exit 1 ; fi

# Initialise Optset
eval set -- "$OPTSET"

# Default variable values
fileTypes="*.aux *.bbl *.bcf *.blg *.fdb_latexmk *.fls *.log *.run.xml *.synctex.gz"
userConfirm=true

# Function for displaying help message
usage() {
    echo "Usage: $0 [OPTIONS]"
    echo "removes LaTeX build files from the current directory"
    echo "Options:"
    echo " -h | --help      Dispay this help message"
    echo " -y | --yes       Runs command without asking for confimation"
    echo " -v | --version   Displays version number"
   }

# Version information
version() {
    echo "texclean $Version"
    echo "Release Date: $Date"
}

# Primary script function
texclean() {
    echo "The following files will be deleated:"
    find $fileTypes
    if [ $userConfirm = false ];
        then
            rm $fileTypes
        else
            read -p "Do you want to continue? [Y/n]  " -r
            if [[ $REPLY =~ ^[Yy]$ ]]
                    then
                        rm $fileTypes
                        echo "Done"   # remove files
            fi
fi
}

# No Confirm Function
noConfirmClean() {
    rm $fileTypes
    echo "Done"
}


# Function loop
while true; do
    case "$1" in
        -h | --help ) usage ; exit 0 ;;
        -y | --yes ) noConfirmClean ; exit 0;;
        -v | --version ) version ; exit 0 ;;
        * ) texclean ; exit 0 ;;
    esac
done
