FROM postgres:15-bookworm
RUN apt-get update
RUN apt-get install -y git curl
RUN apt-get install -y build-essential pkg-config libssl-dev
RUN apt-get install -y postgresql-server-dev-15
RUN apt-get install -y bison flex zlib1g zlib1g-dev make libreadline-dev
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"
RUN cargo install cargo-pgrx --version 0.9.8 --locked
RUN cargo pgrx init --pg15="/usr/bin/pg_config"
RUN git clone --depth 1 https://github.com/zombodb/zombodb.git
WORKDIR zombodb
RUN cargo pgrx install --release