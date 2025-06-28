
# neovim (neovim)

Tooling for running neovim

## Options

| Options Id | Description | Type | Default Value |
|-----|-----|-----|-----|
| imageVariant | Ubuntu version. Version numbers or names(e.g. jammy, noble) can be used. | string | 24.04 |
| user | Container user. Some tooling will be installed in this user directory so the username needs to be selected for this. Ubuntu is the default user in this container | string | ubuntu |
| neovimConfig | Neovim Configuration repository to use. Custom configurations can be used but currently priavate repositories can't be used. Use https clone urls not ssh | string | none |
| neovimVersion | Version of Neovim to install. Neovim versions can be changed by using bob | string | stable |

# Neovim Template
This template provides Neovim and dependencies/tools. This Template is designed for users who prefer a terminal focused workflow instead of vscode.

## What does  this template provide?
- Ubuntu - Uses the ubuntu distro with several common dependencies installed. Ubuntu versions can be selected in this template.
- tmux/zellij - Window managers
- bob - Neovim package manager for installing and changing neovim version
- Neovim tools - commonly used tools for neovim.
    - xclip
    - fd-find
    - ripgrep
    - fzf

## FAQ
### Can I use the Mason package manager?
Yes but it's not recommended or supported. Using Mason defeats the point of working in a devcontainer. Dependencies should be installed by a devcontainer's dockerfile or as a feature. Using Mason runs the risk of having a "Works on my machine" issue. Mason should still work in the devcontainer but extra dependencies may be needed to install some of the it's packages and there is no plans to properly support it.  

### can I use a my own neovim configuration files?
Yes with a caveat. Currently using the `neovimConfig` template option will clone the repository into the container at build time, if done this way the neovim configuration repository needs to be public. Private repositories would require authentication and currently there is no good way to securely handle credentials.

The alternative is to sett `neovimConfig` to `none` and clone in your repository at runtime.

### What is bob and why is it used?
bob is a neovim package manager. It provides a easy way to install/change neovim versions. Neovim versions can be changed at runtime by using the `bob use <VERSION>` command. Find out more on https://github.com/MordechaiHadad/bob.

### Can I speed up build times?
Yes! There are several ways to handle this.

#### Prebuilds
Use a prebuilds to store containers. This means all you need to do is build once and the pull that image in future. prebuild docs: https://containers.dev/guide/prebuild

#### Removing apt-get dependencies
The simplest solution is to remove tools you don't use. In the `dockerfile` you can remove any tools from the `apt-get` installs under the `tools` comment. Do note these aren't required to run neovim but may cause issue with plugins like `telescope` if not installed.

#### Removing Zellij dependencies
Zellij is the dependency that take the most time to build so if you don't need it or use `tmux` instead, removing it will lower build times significantly.

to remove comment out or delete these lines:
```bash
RUN rustup update && cargo install --locked zellij
```

```bash
COPY --from=builder /usr/local/cargo/bin/zellij /usr/local/bin/
```

```bash
ENV ZELLIJ_SOCKET_DIR="/tmp/zellij"
```

### Why is Neovim is showing visual glitches?
Some visual issues have been observed with using neovim inside a container. Using `tmux` or `zellij` can fix some of these issues.

---

_Note: This file was auto-generated from the [devcontainer-template.json](https://github.com/BrandonC98/devcontainer-templates/blob/main/src/neovim/devcontainer-template.json).  Add additional notes to a `NOTES.md`._
