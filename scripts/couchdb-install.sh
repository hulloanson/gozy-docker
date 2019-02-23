# Install
couchdb_version='2.3.0'
cd /tmp && \
    curl -LO "https://dist.apache.org/repos/dist/release/couchdb/source/${couchdb_version}/apache-couchdb-${couchdb_version}.tar.gz" && \
    tar xf apache-couchdb-$couchdb_version.tar.gz && \
    cd apache-couchdb-$couchdb_version && \
    ./configure && \
    make release && \
    adduser --system \
            --no-create-home \
            --shell /bin/bash \
            --group --gecos \
            "CouchDB Administrator" couchdb && \
    cp -R rel/couchdb /home/couchdb && \
    chown -R couchdb:couchdb /home/couchdb && \
    find /home/couchdb -type d -exec chmod 0770 {} \; && \
    chmod 0644 /home/couchdb/etc/* && \
    mkdir /var/log/couchdb && chown couchdb: /var/log/couchdb && \

# Configure
sudo -b -i -u couchdb sh -c '/home/couchdb/bin/couchdb >> /var/log/couchdb/couch.log 2>> /var/log/couchdb/couch-err.log' && \
    sleep 30 && \
    curl -X PUT http://127.0.0.1:5984/_users && \
    curl -X PUT http://127.0.0.1:5984/_replicator && \
    curl -X PUT http://127.0.0.1:5984/_global_changes
