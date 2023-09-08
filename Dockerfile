FROM jenkins/jenkins:lts-alpine
USER root

# install python
RUN apk add python3 && \
 python3 -m ensurepip && \
 pip3 install --upgrade pip setuptools && \
 if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi && \
 if [[ ! -e /usr/bin/python ]]; then ln -sf /usr/bin/python3 /usr/bin/python; fi && \
 rm -r /root/.cache
 
RUN apk add pkgconf
RUN apk add build-base
RUN apk add python3-dev

# install docker
RUN apk add --update docker openrc
RUN rc-update add docker boot

RUN apk add shadow
# provide docker permissions for jenkins user
RUN usermod -a -G docker jenkins
RUN chmod 777 /var/run/docker.sock

USER jenkins

