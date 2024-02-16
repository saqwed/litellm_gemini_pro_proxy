FROM alpine:3.19.1 AS alpine

# google-generativeai need python 3.10
ENV PYTHON_VERSION=3.10.13

RUN apk add --update bash python3 py3-pip

WORKDIR $HOME

# Install litellm and google-generativeai
# TODO: Study avoid --break-system-packages
ADD requirements.in /
ADD requirements.txt /
RUN pip install --break-system-packages \
      -r requirements.txt

ADD init.sh /
RUN chmod 700 init.sh
ENTRYPOINT [ "/init.sh" ]
