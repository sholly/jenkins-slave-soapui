FROM registry.redhat.io/openshift4/ose-jenkins-agent-base:v4.5.0
#FROM quay.io/openshift/origin-jenkins-agent-base:v4.0

ENV SOAPUI_VERSION=5.6.0
RUN echo $SOAPUI_VERSION

RUN mkdir -p /opt && \
  curl -k https://s3.amazonaws.com/downloads.eviware/soapuios/5.6.0/SoapUI-5.6.0-linux-bin.tar.gz \
    | gunzip -c - | tar -xf - -C /opt && \
    ln -s /opt/SoapUI-${SOAPUI_VERSION} /opt/SoapUI

ENV PATH ${PATH}:/opt/SoapUI/bin

USER 1001

