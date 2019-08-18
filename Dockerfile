FROM debian:stretch

LABEL author shazic
LABEL email shashank.chattopadhyaya@gmail.com

# Install pygments (for syntax highlighting) 
RUN apt-get -qq update \
	&& DEBIAN_FRONTEND=noninteractive apt-get -qq install -y --no-install-recommends libstdc++6 python-pygments git ca-certificates asciidoc curl \
	&& rm -rf /var/lib/apt/lists/*

# Configuration variables
ENV HUGO_VERSION 0.56.2
ENV HUGO_BINARY hugo_extended_${HUGO_VERSION}_Linux-64bit.deb
ENV SITE_DIR '/usr/share/hugo'

# Download and install hugo
RUN curl -sL -o /tmp/hugo.deb \
    https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/${HUGO_BINARY} && \
    dpkg -i /tmp/hugo.deb && \
    rm /tmp/hugo.deb && \
    mkdir ${SITE_DIR}

WORKDIR ${SITE_DIR}

# Automatically build site
ADD site/ ${SITE_DIR}

