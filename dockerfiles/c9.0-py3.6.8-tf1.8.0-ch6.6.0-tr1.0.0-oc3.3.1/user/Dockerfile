ARG BASECONTAINER="opiopan/dlenv-utils:c9.0-py3.6.8-tf1.8.0-ch6.6.0-tr1.0.0-oc3.3.1"

FROM ${BASECONTAINER}
LABEL maintainer "opiopan@gmail.com"

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        gosu sudo && \
    apt-get clean

RUN grep -v secure_path /etc/sudoers > /etc/sudoers.new && \
    echo 'Defaults env_keep += "PATH"' >> /etc/sudoers.new && \
    echo 'Defaults env_keep += "PYENV_ROOT"' >> /etc/sudoers.new && \
    mv /etc/sudoers.new /etc/sudoers
COPY entrypoint /boot/entrypoint
RUN chmod +x /boot/entrypoint
ENTRYPOINT ["/boot/entrypoint"]
