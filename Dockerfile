FROM ubuntu:latest

RUN apt update 
RUN apt install software-properties-common \
  python3 python3-pip python3-venv

COPY requirements.txt /requirements.txt

RUN pip install -r /requirements.txt

LABEL org.opencontainers.image.source=https://github.com/db-tu-dresden/TSLGen
LABEL org.opencontainers.image.description="TSLGenerator Compilation Image for x86"
LABEL org.opencontainers.image.licenses=Apache-2.0

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
