FROM ubuntu:14.04

ARG CHEF_CHANNEL

ENV CHEF_CHANNEL ${CHEF_CHANNEL:-stable}
ENV CHEF_FQDN chef-server
ENV CHEF_USER super
ENV CHEF_NAME Super User
ENV CHEF_PASS password
ENV CHEF_EMAIL super@chef.io
ENV CHEF_ORG_SHORT local
ENV CHEF_ORG_FULL Local Development

ENV CHEFDK_VERSION 1.1.16
ENV CHEFDK_DOWNLOAD_URL https://packages.chef.io/files/stable/chefdk/${CHEFDK_VERSION}/ubuntu/14.04/chefdk_${CHEFDK_VERSION}-1_amd64.deb
ENV CHEFDK_DOWNLOAD_SHA256 7a1bed7f6eae3ae26694f9d3f47ce76d5e0cbbaba72dafcbc175e89ba0ac6dd9

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends curl \
      && curl -kfsSL "$CHEFDK_DOWNLOAD_URL" -o chefdk_${CHEFDK_VERSION}-1_amd64.deb \
      && dpkg -i chefdk_${CHEFDK_VERSION}-1_amd64.deb \
      && rm chefdk_${CHEFDK_VERSION}-1_amd64.deb \
      && rm -rf /var/lib/apt/lists/*

ENV PATH=/opt/chefdk/bin:/opt/chefdk/embedded/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

VOLUME /volumes/keys

COPY setup.rb install.rb run.sh /

RUN chef-apply install.rb

EXPOSE 443

CMD ["bash", "-c", "/run.sh"]
