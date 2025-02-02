ARG BASE_IMAGE="ghcr.io/gbraad-devenv/fedora/rdesktop"
ARG BASE_VERSION=41

FROM ${BASE_IMAGE}:${BASE_VERSION}

USER root

RUN curl -fsSL https://github.com/shiftkey/desktop/releases/download/release-3.4.8-linux1/GitHubDesktop-linux-x86_64-3.4.8-linux1.rpm \
        -o /tmp/gd.rpm \
    && dnf install -y \
	    epiphany \
        /tmp/gd.rpm \
    && dnf clean all \
    && rm -rf /var/cache/yum \
    && rm -f /tmp/pd.rpm \
    && git config -f /etc/rdesktop/rdesktop.ini \
	    rdesktop.title "GitHub Desktop" \
    && git config -f /etc/rdesktop/rdesktop.ini \
	    rdesktop.exec "github-desktop"

# ensure to become root for systemd
#ENTRYPOINT ["/sbin/init"]
