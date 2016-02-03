#!/usr/bin/env bash

# This script installs and configures the dependencies for the project

declare OS_NAME

case `uname` in 
    Darwin)     OS_NAME="osx"    ;;
    Linux)      OS_NAME="linux"  ;;
esac

echo "Building on: ${OS_NAME}"

if env | grep -qE '^(?:TRAVIS|CI)='; then
#    We're on Travis, intialize variables:
    echo "Detected CI Build -> CI=${CI}"
else
#   We're building locally
    export CI=false
    echo "Detected Local Build -> CI=${CI}"
fi


install_os_deps() {
    # Install all of the OS specific OS dependencies

    case ${OS_NAME} in
        osx)
            echo "brew update ..."; brew update > /dev/null

            if [ "${CC}" = "gcc" ]; then 
                export CC=gcc-4.8 
                export CXX=g++-4.8
            fi

            brew unlink cmake
            brew install cmake 
        ;;

        linux) 
            case ${COMPILER} in 
                clang*) 
                    export CC=`echo ${COMPILER} | sed 's/\+\+//g'` ; 
                    export CXX="${COMPILER}" ; 
                ;;

                g++*)
                    export CC=`echo ${COMPILER} | sed 's/\+\+/cc/g'` ; 
                    export CXX="${COMPILER}" ; 
                ;;
            esac
        ;;
    esac

}

get_v8_gem_dir() {
    
    echo $(dirname $(dirname $(find $(gem env gemdir) -name 'v8.h' | tail -n 1)))

}

install_os_deps

# install_manual_deps
