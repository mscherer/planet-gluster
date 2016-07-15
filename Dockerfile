FROM fedora:latest
MAINTAINER Michael Scherer

RUN dnf install -y make redhat-rpm-config git tar rubygem-bundler ruby-devel curl-devel zlib-devel patch ImageMagick gcc-c++ && dnf clean all
RUN useradd middleman -d /srv/middleman

USER middleman

ADD . /srv/middleman
WORKDIR /srv/middleman
RUN ["/usr/bin/bundle","install"]
ENV PATH /usr/bin:/bin:/srv/middleman/bin
RUN ["/usr/bin/bundle", "exec", "middleman", "build"]

ENTRYPOINT ['/bin/ls']
#ENTRYPOINT ["/usr/bin/bundle", "exec", "middleman"]

#CMD ['server']

EXPOSE 4567
