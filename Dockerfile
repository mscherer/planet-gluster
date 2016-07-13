FROM fedora:latest
MAINTAINER Michael Scherer

RUN dnf install -y make redhat-rpm-config rubygem-bundler ruby-devel curl-devel zlib-devel patch ImageMagick gcc-c++ && dnf clean all
RUN useradd middleman -d /srv/middleman
USER middleman
ADD . /srv/middleman
WORKDIR /srv/middleman
RUN bundle install
RUN bundle exec middleman build
CMD bundle exec middleman server
EXPOSE 4567
