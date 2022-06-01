#!/bin/bash
export FORCE_UNSAFE_CONFIGURE=1
mkdir -p /WORKDIR/build
rm -rf /WORKDIR/build/*
cp -rf /WORKDIR/source/* /WORKDIR/build/
cd /WORKDIR/build/gluon && git pull
cd /WORKDIR/build/gluon/site && git pull
cd /WORKDIR/build/gluon
make update
NUM_CORES_PLUS_ONE=$(expr $(nproc) + 1)
make GLUON_TARGET=ar71xx-generic GLUON_AUTOUPDATER_BRANCH=$UPDATERBRANCH GLUON_AUTOUPDATER_ENABLED=1 -j$NUM_CORES_PLUS_ONE V=sc
make GLUON_TARGET=mpc85xx-generic GLUON_AUTOUPDATER_BRANCH=$UPDATERBRANCH GLUON_AUTOUPDATER_ENABLED=1 -j$NUM_CORES_PLUS_ONE V=sc
make manifest GLUON_RELEASE=$GLUON_RELEASE GLUON_AUTOUPDATER_BRANCH=$UPDATERBRANCH

if [ "$SECRETKEY" != "NONE" ]; then
    contrib/sign.sh $SECRETKEY output/images/sysupgrade/$UPDATERBRANCH.manifest
fi
