#!/bin/bash
# CLI for removing LaTeX build file

Version="0.2"
Date="2023/12/11"

# getopt setup
OPTSET=$(getopt -o hyvr --long help,yes,version,recursive \
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
    echo " -h | --help          Dispay this help message"
    echo " -y | --yes           Runs command without asking for confimation"
    echo " -r | --recursive     Runs command in all subfolders"
    echo " -v | --version       Displays version number"
   }

# Version information
version() {
    echo "texclean $Version"
    echo "Release Date: $Date"
}

# Primary script function
texclean() {
    echo "The following files will be deleated:"
    find $fileTypes -print
            read -p "Do you want to continue? [Y/n]  " -r
            if [[ $REPLY =~ ^[Yy]$ ]]            then
                rm $fileTypes 2> /dev/null
                echo "Done"   # removes file with no output to the terminal
            fi
}

# No Confirm Function
noConfirmClean() {
    rm $fileTypes 2> /dev/null  # removes files with no output to the terminal
    echo "Done"
}

# Recusive Clean Function
recursiveClean() {
    echo "the following files will be deleated:"
    find . -name "*.aux" -type f -print
    find . -name "*.bbl" -type f -print
    find . -name "*.bcf" -type f -print
    find . -name "*.blg" -type f -print
    find . -name "*fdb_latexmk" -type f -print
    find . -name "*.fls" -type f -print
    find . -name "*.run.xml" -type f -print
    find . -name "synctex.gz" -type f -print
    echo "Recursive mode will not remove generated .log files"
    read -p "Do you want to continue? [Y/n]  " -r 
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            find . -name "*.aux" -type f -delete 2> /dev/null
            find . -name "*.bbl" -type f -delete 2> /dev/null
            find . -name "*.bcf" -type f -delete 2> /dev/null
            find . -name "*.blg" -type f -delete 2> /dev/null
            find . -name "*fdb_latexmk" -type f -delete 2> /dev/null
            find . -name "*.fls" -type f -delete 2> /dev/null
            find . -name "*.run.xml" -type f -delete 2> /dev/null
            find . -name "synctex.gz" -type f -delete 2> /dev/null
            echo "Done"
        fi
}

# Function loop
while true; do
    case "$1" in
        -h | --help ) usage ; exit 0 ;;
        -y | --yes ) noConfirmClean ; exit 0;;
        -v | --version ) version ; exit 0 ;;
        -r | --recursive ) recursiveClean ; exit 0 ;;
        * ) texclean ; exit 0 ;;
    esac
done
