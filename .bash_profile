export PATH="$PATH:/opt/mssql-tools/bin"
export PATH="$PATH:/opt/mssql-tools/bin"

export PATH="$HOME/.poetry/bin:$PATH"

source "$HOME/.bashrc"
. "$HOME/.cargo/env"
eval "$(/home/fbaltor/.linuxbrew/bin/brew shellenv)"
eval "$(/home/fbaltor/.linuxbrew/bin/brew shellenv)"
eval "$(/home/fbaltor/.linuxbrew/bin/brew shellenv)"
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"


# Added by Toolbox App
export PATH="$PATH:/home/fbaltor/.local/share/JetBrains/Toolbox/scripts"

# Added by serverless binary installer
export PATH="$HOME/.serverless/bin:$PATH"

# >>> coursier install directory >>>
export PATH="$PATH:/home/fbaltor/.local/share/coursier/bin"
# <<< coursier install directory <<<

# >>> juliaup initialize >>>

# !! Contents within this block are managed by juliaup !!

case ":$PATH:" in
    *:/home/fbaltor/.juliaup/bin:*)
        ;;

    *)
        export PATH=/home/fbaltor/.juliaup/bin${PATH:+:${PATH}}
        ;;
esac

# <<< juliaup initialize <<<

# Pyenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
