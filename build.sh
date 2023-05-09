#!/bin/bash

CURDIR=$( cd "$( dirname "$0" )" && pwd );
echo -e "\033[0;32mBuild: ${CURDIR} \033[0m";

CMAKE="";
if [ "$( cmake  --version 2>&1 | grep version | awk '{print $3 }' | awk -F '.' '{print $1}' )" == 3 ] ; then CMAKE=cmake; fi
if [ "$( cmake3 --version 2>&1 | grep version | awk '{print $3 }' | awk -F '.' '{print $1}' )" == 3 ] ; then CMAKE=cmake3; fi
if [ "$CMAKE" == "" ] ; then echo "Can't find cmake > 3.0"; exit; fi

print_usage()
{
  echo "$0 mpeg-pcc-dmetric building script: "
  echo "";
  echo "    Usage:"
  echo "       -h|--help    : Display this information."
  echo "       --ouptut     : Output build directory."
  echo "       --debug      : Build in debug mode."
  echo "       --release    : Build in release mode."
  echo "       --doc        : Build documentation (latex and pdflatex requiered)"
  echo "       --format     : Format source code"
  echo "";
  echo "    Examples:";
  echo "      $0 ";
  echo "      $0 --debug";
  echo "      $0 --doc";
  echo "      $0 --format";
  echo "    ";
  if [ $# != 0 ] ; then echo -e "ERROR: $1 \n"; fi
  exit 0;
}

# PARSE OPTIONS
MODE=Release
TARGETS=()
CMAKE_FLAGS=()
OUTPUT=build
case $(uname -s) in Linux*) NUMBER_OF_PROCESSORS=$( grep -c ^processor /proc/cpuinfo );; esac
for i in "$@"
do
  C=$1; if [[ "$C" =~ [=] ]] ; then V=${C#*=}; elif [[ $2 == -* ]] ; then  V=""; else V=$2; shift; fi;
  case "$C" in
    -h|--help      ) print_usage;;
    --output=*     ) OUTPUT=${V};;
    --debug        ) MODE=Debug; CMAKE_FLAGS+=("-DCMAKE_C_FLAGS=\"-g2\"" "-DCMAKE_CXX_FLAGS=\"-g2\"" );;
    --release      ) MODE=Release;;
    --doc          ) make -C ${CURDIR}/doc/; exit;;
    --format       ) TARGETS+=( "clang-format" );;
    --CMAKE_FLAGS=*) CMAKE_FLAGS+=( ${V} );;
    --ninja        ) CMAKE_FLAGS+=( "-GNinja" );;
    *              ) print_usage "arguments \"$C\" not supported."; exit -1;;
  esac
  shift;
done

# CMAKE
echo -e "\033[0;32mCmake: ${CURDIR} \033[0m";
if ! ${CMAKE} -H${CURDIR}/source/ -B"${CURDIR}/${OUTPUT}/${MODE}" "${CMAKE_FLAGS[@]}";
then
  echo -e "\033[1;31mfailed \033[0m"
  exit 1;
fi

# CUSTOM TARGETS
if (( ${#TARGETS[@]} ))
then
  for TARGET in ${TARGETS[@]}
  do
    echo -e "\033[0;32m${TARGET}: ${CURDIR} \033[0m";
    ${CMAKE} --build "${CURDIR}/${OUTPUT}/${MODE}" --target ${TARGET}
    echo -e "\033[0;32mdone \033[0m";
  done
  exit 0
fi

# BUILD
echo -e "\033[0;32mBuild: ${CURDIR} \033[0m";
echo "${CMAKE} --build ${CURDIR}/${OUTPUT}/${MODE} --config ${MODE} --parallel ${NUMBER_OF_PROCESSORS}"
if ! ${CMAKE} --build "${CURDIR}/${OUTPUT}/${MODE}" --config ${MODE} --parallel "${NUMBER_OF_PROCESSORS}" ;
then
  echo -e "\033[1;31mfailed \033[0m"
  exit 1;
fi
echo -e "\033[0;32mdone\033[0m";
