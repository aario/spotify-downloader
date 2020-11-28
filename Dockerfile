FROM alpine
ARG UID=1000
RUN addgroup -g $UID spotdl \
    && adduser -u $UID spotdl -G spotdl -D -h /local \
    && mkdir -p /local \
    && chown -R spotdl:spotdl /local \
    && apk update \
    && apk add \
        bash \
        git \
        gcc \
        g++ \
        python3 \
        python3-dev \
        py3-setuptools \
        ffmpeg \
    && cd /root \
    && git clone https://github.com/nficano/pytube.git \
    && cd pytube \
    && python3 ./setup.py install \
    && cd /root \
    && git clone https://github.com/aario/spotify-downloader.git \
    && cd spotify-downloader/ \
    && git checkout youtube-dl \
    && python3 ./setup.py install \
    && cd /root \
    && git clone https://github.com/ytdl-org/youtube-dl \
    && cd youtube-dl/ \
    && python3 setup.py install \
    && rm -rf /root/spotify-downloader \
    && apk del \
        git \
        gcc \
        g++ \
        python3-dev

WORKDIR "/local"
CMD ["/bin/bash"]
