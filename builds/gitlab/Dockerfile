
FROM gitlab/gitlab-ce:10.8.4-ce.0
LABEL maintainer="Paolo D'Onorio De Meo <paolo@proofmedia.io>"
# TODO: push build image to docker hub
# FIXME: change instructions in that direction

VOLUME /templates/
COPY gitlab.rb /templates/
COPY docker-entrypoint.sh /usr/local/bin/entry
COPY backup-cron /etc/cron.d/backup-cron
RUN cd /usr/local/bin/ && \
    wget -O expand_secrets http://bit.ly/secrets_expand_script \
    && chmod +x entry expand_secrets

# ENTRYPOINT ["/bin/bash"]
CMD /usr/local/bin/entry
