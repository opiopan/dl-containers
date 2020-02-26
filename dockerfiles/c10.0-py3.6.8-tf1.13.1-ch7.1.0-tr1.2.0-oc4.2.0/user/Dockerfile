ARG BASECONTAINER="opiopan/dlenv-utils:c10.0-py3.6.8-tf1.13.1-ch7.1.0-tr1.2.0-oc4.2.0"

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
