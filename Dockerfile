FROM fedora:latest
MAINTAINER Michael Scherer

RUN dnf install -y make redhat-rpm-config git tar rubygem-bundler ruby-devel curl-devel zlib-devel patch ImageMagick gcc-c++ findutils && dnf clean all
RUN useradd middleman -d /srv/middleman -g 0 -K 'UMASK=002' -u 1000


ADD . /srv/middleman
WORKDIR /srv/middleman
RUN /usr/bin/bundle install
ENV PATH /usr/bin:/bin:/usr/local/bin
RUN /usr/bin/bundle exec middleman build

USER 1000
CMD ["/usr/bin/sleep", "3d"]
#ENTRYPOINT ["/usr/bin/bundle", "exec", "middleman"]
#CMD ["server"]

EXPOSE 4567
