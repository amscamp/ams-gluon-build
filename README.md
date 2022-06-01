# amscamp gluon Build

This image is intended to build [gluon](https://github.com/freifunk-gluon/gluon.git) .

### Download

```shell
git clone https://github.com/amscamp/ams-gluon-build.git;
docker build -t amscamp/ams-gluon-build:latest -f ams-gluon-build/linux.Dockerfile ams-gluon-build;
```

### Run gluon build
```shell
docker run -it --rm -v $PWD/output:/WORKDIR/build amscamp/ams-gluon-build:latest
```

