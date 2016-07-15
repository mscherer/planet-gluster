FROM fedora:latest
MAINTAINER Michael Scherer

RUN dnf install -y make redhat-rpm-config git tar rubygem-bundler ruby-devel curl-devel zlib-devel patch ImageMagick gcc-c++ && dnf clean all
RUN useradd middleman -d /srv/middleman -g 0 -K 'UMASK=002' -u 1000

USER 1000

ADD . /srv/middleman
WORKDIR /srv/middleman
RUN /usr/bin/bundle install
ENV PATH /usr/bin:/bin:/srv/middleman/bin
RUN /usr/bin/bundle exec middleman build

USER root
RUN /usr/bin/chgrp -R 0 /srv/middleman
RUN /usr/bin/chmod -R g+rw /srv/middleman
RUN /usr/bin/find /srv/middleman -type d -exec chmod g+x {} +

USER 1000
#CMD ["/usr/bin/sleep", "3d"]
ENTRYPOINT ["/usr/bin/bundle", "exec", "middleman"]
CMD ["server"]

EXPOSE 4567
