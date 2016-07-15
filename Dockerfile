FROM fedora:latest
MAINTAINER Michael Scherer

RUN dnf install -y make redhat-rpm-config git tar rubygem-bundler ruby-devel curl-devel zlib-devel patch ImageMagick gcc-c++ && dnf clean all
RUN useradd middleman -d /srv/middleman

USER middleman

ADD . /srv/middleman
WORKDIR /srv/middleman
RUN bundle install
ENV PATH /usr/bin:/bin:/srv/middleman/bin
RUN bundle exec middleman build

CMD ls && pwd && bundle exec middleman server

EXPOSE 4567
