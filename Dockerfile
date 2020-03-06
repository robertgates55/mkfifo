FROM ubuntu:18.04 AS mkfifo_builder
RUN apt-get update
RUN apt-get -y install make wget gcc xz-utils
WORKDIR /build
RUN wget https://ftp.gnu.org/gnu/coreutils/coreutils-8.31.tar.xz
RUN tar xf coreutils-*
WORKDIR coreutils-8.31
#RUN sed -i 's/ac_clean_files="$ac_clean_files confdir3"/ac_clean_files="$ac_clean_files"/g' configure
RUN FORCE_UNSAFE_CONFIGURE=1 ./configure
RUN make

FROM alpine:latest
COPY --from=mkfifo_builder /build/coreutils-8.31/src/mkfifo /usr/bin/mkfifo
