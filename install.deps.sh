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
            # brew unlink boost 
            # brew install qt5 cmake boost
            # brew link qt5 --force

            export BOOST_ROOT="/usr/local/"

        ;;

        linux) 
            if [ "${OS_NAME}" == "linux"] && [ "${CC}" == "clang" ]; then 
                export CC="clang-3.6" ;
                export CXX="clang++-3.6" ;
            fi 
            
            # if [ ! -d vendor/src ]; then mkdir vendor/ ; mkdir vendor/src; fi
            # cd vendor/src

            # local b_underscore=`echo ${BOOST_VERSION} | sed 's/\./_/g'`
            # local b_url="http://downloads.sourceforge.net/project/boost/boost/${BOOST_VERSION}/boost_${b_underscore}.tar.bz2"
            # local b_archive="boost_${b_underscore}.tar.bz2"
            # if [ ! -f "./${b_archive}" ]; then 
            #     echo "Downloading Boost ${BOOST_VERSION}"
            #     wget --no-check-certificate ${b_url} -O ${b_archive}
                
            # fi
             
            # if [ ! -d "${BOOST_ROOT}" ]; then  
            #     echo "Extracting ${b_archive} ..." 
            #     tar xjf ${b_archive}

            #     # Build it:
            #     echo "Installing Boost ${BOOST_VERSION} ..."
            #     cd boost_${b_underscore}
            #     ./bootstrap.sh --prefix=${BOOST_ROOT}
            #     ./b2 -d1 install

            #     cd -
            # else 
            #     echo "Found cached Boost ${BOOST_VERSION} @ ${b_archive}"
            # fi

        ;;
    esac
}

# install_manual_deps() {
    
# }

install_os_deps

# install_manual_deps
