FROM ubuntu:22.04 AS ubuntu

# google-generativeai need python 3.10
ENV PYTHON_VERSION=3.10.13

# Install necessary packages
RUN set -ex && apt-get update && \
      apt-get install -y --no-install-recommends \
            ca-certificates \
            curl \
            git \
            build-essential \
            zlib1g-dev \
            libffi-dev \
            libssl-dev \
            libbz2-dev \
            libreadline-dev \
            libsqlite3-dev \
            liblzma-dev \
            && \
      apt-get autoremove --purge && \
      apt-get -y clean && \
      rm -rf /var/lib/apt/lists/*

WORKDIR $HOME

# Install pyenv and python3
ENV PYENV_ROOT="$HOME/.pyenv"
ENV PATH="$PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH"
RUN curl https://pyenv.run | bash
RUN pyenv update
RUN pyenv install ${PYTHON_VERSION}
RUN pyenv global ${PYTHON_VERSION}
RUN pyenv rehash

# Add necessary settings for pyenv
RUN echo 'export PYENV_ROOT="$HOME/.pyenv"' >> $HOME/.bashrc
RUN echo 'export PATH="$PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH"' >> $HOME/.bashrc
RUN echo 'eval "$(pyenv init -)"' >> $HOME/.bashrc

# Install uv
RUN pip install uv

# Activate virtual environment
RUN uv venv
RUN . .venv/bin/activate

# Install litellm and google-generativeai
# RUN uv pip install litellm litellm[proxy] google-generativeai
ADD requirements.in /
# RUN uv pip compile --python-version=${PYTHON_VERSION} requirements.in -o requirements.txt
ADD requirements.txt /
RUN uv pip install -r requirements.txt

ADD init.sh /
RUN chmod 700 init.sh
ENTRYPOINT [ "/init.sh" ]
