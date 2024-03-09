# escape=`

FROM debian:12
ARG GLUONVERSION=v2020.2.x
ARG SITEVERSION=main
ARG BUILDNODE=unspecified
ARG SOURCE_COMMIT=unspecified
ENV UPDATERBRANCH=beta
ENV SECRETKEY=NONE

LABEL com.lacledeslan.build-node=$BUILDNODE `
      org.label-schema.schema-version="1.0" `
      org.label-schema.url="https://amscamp.de" `
      org.label-schema.vcs-ref=$SOURCE_COMMIT `
      org.label-schema.vendor="amscamp" `
      org.label-schema.description="amscamp gluon build container" `
      org.label-schema.vcs-url="https://github.com/amscamp/ams-gluon-build"


RUN apt-get update && apt-get install -y `
    git make flex gawk grep libc-dev libz-dev perl python3 rsync subversion unzip build-essential wget file libncurses-dev &&`
    apt-get clean &&`
    rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*;

WORKDIR /WORKDIR/source

RUN git clone https://github.com/freifunk-gluon/gluon.git gluon -b $GLUONVERSION
RUN git clone https://github.com/amscamp/ams-gluon-site.git gluon/site -b $SITEVERSION

COPY /dist /app

RUN chmod +x /app/linux/*.sh;

VOLUME /WORKDIR/build

CMD ["/app/linux/buildscript.sh"]
