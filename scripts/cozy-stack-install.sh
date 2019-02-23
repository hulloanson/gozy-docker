cozy_stack_version='1.2.1'

# Install
curl -o /usr/local/bin/cozy-stack -L https://github.com/cozy/cozy-stack/releases/download/$cozy_stack_version/cozy-stack-linux-amd64 && \
chmod +x /usr/local/bin/cozy-stack && \
adduser --system \
        --shell /bin/bash \
        --group --gecos \
        "Cozy" cozy && \
# Configure
    # @FIXME we should remove this hack and use `--fs-url file://localhost/var/lib/cozy` once its available
mkdir /usr/local/bin/storage && \
chown cozy: /usr/local/bin/storage && \
mkdir /var/log/cozy && \
chown cozy: /var/log/cozy && \
mkdir /var/lib/cozy && \
chown -R cozy: /var/lib/cozy && \
mkdir /etc/cozy && \
curl -o /etc/cozy/cozy.yaml https://raw.githubusercontent.com/cozy/cozy-stack/master/cozy.example.yaml && \
sed -i 's#/path/to/key#/etc/cozy/credentials-key#g' /etc/cozy/cozy.yaml

chown -R cozy: /etc/cozy
