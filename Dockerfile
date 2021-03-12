FROM registry.fedoraproject.org/fedora:33 AS fedora-build

ADD . /srv

RUN dnf install -y rubygem-bundler ruby-devel curl-devel make gcc gcc-c++ redhat-rpm-config ImageMagick patch zlib-devel tar git rubygem-bigdecimal && dnf clean all

RUN cd /srv && bundle update --bundler && bundle install && bundle exec middleman build --verbose

FROM registry.access.redhat.com/ubi8/ubi AS server

RUN dnf install -y nginx && dnf clean all

COPY --from=fedora-build /srv/build/ /usr/share/nginx/html

COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 8080

CMD ["/usr/sbin/nginx"]
