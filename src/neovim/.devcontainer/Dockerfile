ARG UBUNTU_VERSION="${templateOption:imageVariant}"

FROM rust:bullseye AS builder

RUN rustup update && cargo install --locked zellij
RUN rustup update && cargo install --locked bob-nvim

FROM buildpack-deps:${UBUNTU_VERSION}-curl
ARG USERNAME="${templateOption:user}"
ARG NVIM_CONFIG="${templateOption:neovimConfig}"
ARG NVIM_VERSION="${templateOption:neovimVersion}"

RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends           \
    # dependencies
    gcc             \
    build-essential \
    make            \
    unzip           \
    git             \
    # Tools
    ripgrep         \
    fd-find         \
    fzf             \
    xclip           \
    tmux            \
    ;               \
    # Clear cache 
    apt-get dist-clean 

# Create the user if they don't exist
RUN id -u ${USERNAME} 2>/dev/null || useradd -ms /bin/bash ${USERNAME}
# Add the user to the sudo group if not already in it
RUN id -nG ${USERNAME} | grep -qw sudo || sudo usermod -aG sudo ${USERNAME}

USER ${USERNAME}

COPY --from=builder /usr/local/cargo/bin/bob /usr/local/bin/
ENV PATH="/home/${USERNAME}/.local/share/bob/nvim-bin/:${PATH}"

# Fix issue that can crashes zellij. https://github.com/zellij-org/zellij/issues/3617 
ENV ZELLIJ_SOCKET_DIR="/tmp/zellij"
COPY --from=builder /usr/local/cargo/bin/zellij /usr/local/bin/

# Install nvim config
RUN if [ "${NVIM_CONFIG}" != "none" ]; then   \
        git clone ${NVIM_CONFIG} "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim; \
    fi

# Set the version of nvim
RUN if [ "${NVIM_VERSION}" != "none" ]; then   \
        bob use ${NVIM_VERSION}; \
    fi