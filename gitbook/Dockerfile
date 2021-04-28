# Base image, default node image
FROM node:13.10-slim

# Environment configuration
ENV	GITBOOK_VERSION3_LATEST="3.2.3"
    

# Install gitbook
RUN npm install --global gitbook-cli \
  && gitbook fetch ${GITBOOK_VERSION3_LATEST} \
  && npm install --global markdownlint-cli \
  && apt-get update \
  && apt-get install --no-install-recommends --no-install-suggests -y \
    sudo \
    git \
    vim \
    calibre \
    fonts-roboto \
    bzip2 \
    ghostscript \
    jpegoptim \
    optipng \
    ca-certificates \
  && npm install svgexport -g --unsafe-perm \
  && npm cache clear --force \
  && rm -rf /var/lib/apt/lists/* \
  && rm -rf /tmp/*

# 定义 Docker 数据卷位置 /gitbook （之后会用于映射到物理硬盘的位置）
ENV BOOKDIR /gitbook
VOLUME $BOOKDIR


# 暴露 4000 端口 （gitbook 默认的服务端口）
EXPOSE 4000


# 定义工作目录为 /gitbook
WORKDIR $BOOKDIR


# 安装完成后打印 gitbook 的帮助文档
CMD ["gitbook", "--help"]
