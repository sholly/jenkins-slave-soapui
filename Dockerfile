#FROM registry.redhat.io/openshift4/ose-jenkins-agent-base:v4.5.0
#FROM quay.io/openshift/origin-jenkins-agent-base:v4.0
#FROM registry.svc.ci.openshift.org/ocp/4.6:jenkins-agent-base
FROM openshift/jenkins-slave-base-centos7:latest

ENV SOAPUI_VERSION=5.6.0
RUN echo $SOAPUI_VERSION
RUN INSTALL_PKGS="java-11-openjdk-devel java-1.8.0-openjdk-devel" && \
    yum install -y $INSTALL_PKGS && \
    rpm -V  java-11-openjdk-devel java-1.8.0-openjdk-devel && \
    yum clean all -y

RUN mkdir -p /opt && \
  curl -k https://s3.amazonaws.com/downloads.eviware/soapuios/5.6.0/SoapUI-5.6.0-linux-bin.tar.gz \
    | gunzip -c - | tar -xf - -C /opt && \
    ln -s /opt/SoapUI-${SOAPUI_VERSION} /opt/SoapUI

ENV PATH ${PATH}:/opt/SoapUI/bin

RUN chown -R 1001:0 $HOME && \
    chmod -R g+rw $HOME

RUN chown -R 1001:0 /opt && \
    chmod -R g+rw /opt

USER 1001

