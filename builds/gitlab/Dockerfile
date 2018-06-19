
FROM gitlab/gitlab-ce:10.8.4-ce.0

COPY docker-entrypoint.sh /usr/local/bin/entry
RUN cd /usr/local/bin/ && \
    wget -O expand_secrets http://bit.ly/secrets_expand_script \
    && chmod +x entry expand_secrets

# ENTRYPOINT ["/bin/bash"]
CMD /usr/local/bin/entry
