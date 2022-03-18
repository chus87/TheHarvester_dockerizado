FROM alpine:3.15
MAINTAINER chus87

WORKDIR /etc

RUN echo -e "http://nl.alpinelinux.org/alpine/v3.11/main\nhttp://nl.alpinelinux.org/alpine/v3.11/community" > /etc/apk/repositories

RUN apk add --update --no-cache bash\
  bash \
  g++ \
  gcc \
  git \
  libffi-dev \
  libxslt-dev \
  python3 \
  build-base \
  py3-pip \
  python3-dev
RUN pip3 install uvloop pyyaml
RUN pip3 install --upgrade pip
RUN git clone https://github.com/laramies/theHarvester.git
RUN pip3 install -r theHarvester/requirements.txt
RUN chmod +x theHarvester/theHarvester.py
RUN apk del --purge py3-pip git build-base libffi-dev python3-dev
RUN rm -rf /var/cache/apk/*

ENTRYPOINT ["/etc/theHarvester/theHarvester.py"]
