source ~/.zplug/init.zsh

zplug "junegunn/fzf", use:"shell/*.zsh"
zplug "junegunn/fzf-bin", from:gh-r, as:command, rename-to:fzf, use:"*linux*amd64*"
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-history-substring-search", defer:3
zplug "softmoth/zsh-vim-mode" 
zplug "hlissner/zsh-autopair", defer:2
zplug "changyuheng/zsh-interactive-cd"
zplug "zsh-users/zsh-autosuggestions"
zplug "zdharma/fast-syntax-highlighting", from:github
zplug load

#set -o vi
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
#
# export PATH=$HOME/bin:/usr/local/bin:$PATH

source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

# Set P10KGT background color, either 'light' or 'dark' (this should match the GNOME Terminal's theme).
P10KGT_BACKGROUND='dark'
if [[ $P10KGT_BACKGROUND != 'light' ]] && [[ $P10KGT_BACKGROUND != 'dark' ]]
then
    P10KGT_ERROR=true
    echo "P10KGT error: variable 'P10KGT_BACKGROUND' should be either 'light' or 'dark'"
fi

# Set P10KGT color scheme, either 'light', 'dark' or 'bright' (choose by preference).
P10KGT_COLORS='bright'
if [[ $P10KGT_COLORS != 'light' ]] && [[ $P10KGT_COLORS != 'dark' ]] && [[ $P10KGT_COLORS != 'bright' ]]
then
    P10KGT_ERROR=true
    echo "P10KGT error: variable 'P10KGT_COLORS' should be either 'light', 'dark' or 'bright'"
fi

# Set P10KGT fonts mode, either 'default', 'awesome-fontconfig', 'awesome-mapped-fontconfig', 'awesome-patched', 'nerdfont-complete' or 'nerdfont-fontconfig'.
# https://github.com/bhilburn/powerlevel9k/wiki/About-Fonts
P10KGT_FONTS='awesome-fontconfig'
if [[ $P10KGT_FONTS != 'default' ]] && [[ $P10KGT_FONTS != 'awesome-fontconfig' ]] && [[ $P10KGT_FONTS != 'awesome-mapped-fontconfig' ]] &&
    [[ $P10KGT_FONTS != 'awesome-patched' ]] && [[ $P10KGT_FONTS != 'nerdfont-complete' ]] && [[ $P10KGT_FONTS != 'nerdfont-fontconfig' ]]
then
    P10KGT_ERROR=true
    echo "P10KGT error: variable 'P10KGT_FONTS' should be either 'default', 'awesome-fontconfig', 'awesome-mapped-fontconfig', 'awesome-patched', 'nerdfont-complete' or 'nerdfont-fontconfig'"
else
    P10K_MODE=$P10KGT_FONTS
fi

if [[ $P10KGT_ERROR != true ]]
then

    # Set P10KGT background color
    if [[ $P10KGT_BACKGROUND == 'light' ]]
    then
        # https://github.com/bhilburn/powerlevel9k/wiki/Stylizing-Your-Prompt#light-color-theme
        P10K_COLOR_SCHEME='light'
        P10KGT_TERMINAL_BACKGROUND=231
    elif [[ $P10KGT_BACKGROUND == 'dark' ]]
    then
        P10K_COLOR_SCHEME='dark'
        P10KGT_TERMINAL_BACKGROUND=236
    fi

    # Set P10KGT foreground colors
    if [[ $P10KGT_COLORS == 'light' ]]
    then
        P10KGT_RED=009
        P10KGT_GREEN=010
        P10KGT_YELLOW=011
        P10KGT_BLUE=012
    elif [[ $P10KGT_COLORS == 'dark' ]]
    then
        P10KGT_RED=001
        P10KGT_GREEN=002
        P10KGT_YELLOW=003
        P10KGT_BLUE=004
    elif [[ $P10KGT_COLORS == 'bright' ]]
    then
        P10KGT_RED=196
        #P10KGT_GREEN=148
        P10KGT_GREEN=154
        P10KGT_YELLOW=220
        P10KGT_BLUE=075
    fi

    # Customize prompt
    # https://github.com/bhilburn/powerlevel9k/wiki/Stylizing-Your-Prompt#adding-newline-before-each-prompt
    P10K_PROMPT_ADD_NEWLINE=true
    # https://github.com/bhilburn/powerlevel9k/tree/next#customizing-prompt-segments
    function virtualenv_prompt_info(){
  return echo "${VIRTUAL_ENV}"
}

    P10K_LEFT_PROMPT_ELEMENTS=(context dir writable dir vcs)
    P10K_RIGHT_PROMPT_ELEMENTS=(status pyenv virtualenv_prompt_info history root_indicator time background_jobs)
    POWERLEVEL9K_PYENV_PROMPT_ALWAYS_SHOW=true
    POWERLEVEL10K_PYENV_PROMPT_ALWAYS_SHOW=true

    # Set 'context' segment colors
    # https://github.com/bhilburn/powerlevel9k/blob/next/segments/context/README.md
    P10K_CONTEXT_DEFAULT_FOREGROUND=$P10KGT_YELLOW
    P10K_CONTEXT_ROOT_FOREGROUND=$P10KGT_YELLOW
    P10K_CONTEXT_SUDO_FOREGROUND=$P10KGT_YELLOW
    P10K_CONTEXT_REMOTE_FOREGROUND=$P10KGT_YELLOW
    P10K_CONTEXT_REMOTE_SUDO_FOREGROUND=$P10KGT_YELLOW
    P10K_CONTEXT_DEFAULT_BACKGROUND=$P10KGT_TERMINAL_BACKGROUND
    P10K_CONTEXT_ROOT_BACKGROUND=$P10KGT_TERMINAL_BACKGROUND
    P10K_CONTEXT_SUDO_BACKGROUND=$P10KGT_TERMINAL_BACKGROUND
    P10K_CONTEXT_REMOTE_BACKGROUND=$P10KGT_TERMINAL_BACKGROUND
    P10K_CONTEXT_REMOTE_SUDO_BACKGROUND=$P10KGT_TERMINAL_BACKGROUND

    # Set 'dir_writable' segment colors
    # https://github.com/bhilburn/powerlevel9k/blob/next/segments/dir_writable/README.md
    P10K_DIR_WRITABLE_FORBIDDEN_FOREGROUND=$P10KGT_YELLOW
    P10K_DIR_WRITABLE_FORBIDDEN_BACKGROUND=$P10KGT_RED

    # Set 'dir' segment colors
    # https://github.com/bhilburn/powerlevel9k/blob/next/segments/dir/README.md
    P10K_DIR_DEFAULT_FOREGROUND=$P10KGT_TERMINAL_BACKGROUND
    P10K_DIR_HOME_FOREGROUND=$P10KGT_TERMINAL_BACKGROUND
    P10K_DIR_HOME_SUBFOLDER_FOREGROUND=$P10KGT_TERMINAL_BACKGROUND
    P10K_DIR_ETC_FOREGROUND=$P10KGT_TERMINAL_BACKGROUND
    P10K_DIR_DEFAULT_BACKGROUND=$P10KGT_BLUE
    P10K_DIR_HOME_BACKGROUND=$P10KGT_BLUE
    P10K_DIR_HOME_SUBFOLDER_BACKGROUND=$P10KGT_BLUE
    P10K_DIR_ETC_BACKGROUND=$P10KGT_BLUE

    # Set 'vcs' segment colors
    # https://github.com/bhilburn/powerlevel9k/blob/next/segments/vcs/README.md
    P10K_VCS_CLEAN_FOREGROUND=$P10KGT_TERMINAL_BACKGROUND
    P10K_VCS_MODIFIED_FOREGROUND=$P10KGT_TERMINAL_BACKGROUND
    P10K_VCS_CLOBBERED_FOREGROUND=$P10KGT_TERMINAL_BACKGROUND
    P10K_VCS_UNTRACKED_FOREGROUND=$P10KGT_TERMINAL_BACKGROUND
    P10K_VCS_CLEAN_BACKGROUND=$P10KGT_GREEN
    P10K_VCS_MODIFIED_BACKGROUND=$P10KGT_YELLOW
    P10K_VCS_CLOBBERED_BACKGROUND=$P10KGT_RED
    P10K_VCS_UNTRACKED_BACKGROUND=$P10KGT_GREEN

    # Set 'status' segment colors
    # https://github.com/bhilburn/powerlevel9k/blob/next/segments/status/README.md
    P10K_STATUS_CROSS=true
    P10K_STATUS_OK_FOREGROUND=$P10KGT_GREEN
    P10K_STATUS_ERROR_FOREGROUND=$P10KGT_RED
    P10K_STATUS_OK_BACKGROUND=$P10KGT_TERMINAL_BACKGROUND
    P10K_STATUS_ERROR_BACKGROUND=$P10KGT_TERMINAL_BACKGROUND

    # Set 'root_indicator' segment colors
    # https://github.com/bhilburn/powerlevel9k/blob/next/segments/root_indicator/README.md
    P10K_ROOT_INDICATOR_FOREGROUND=$P10KGT_YELLOW
    P10K_ROOT_INDICATOR_BACKGROUND=$P10KGT_TERMINAL_BACKGROUND

    # Set 'background_jobs' segment colors
    # https://github.com/bhilburn/powerlevel9k/blob/next/segments/background_jobs/README.md
    P10K_BACKGROUND_JOBS_FOREGROUND=$P10KGT_TERMINAL_BACKGROUND
    P10K_BACKGROUND_JOBS_BACKGROUND=$P10KGT_YELLOW

fi


# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
#ZSH_THEME="powerlevel10k/powerlevel10k"
#ZSH_THEME="random"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"


# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git
    archlinux
    autopep8
    aws
    autojump
    colored-man-pages
    colorize
    command-not-found
    colorize
    colored-man-pages
    pyenv
    django
    git-auto-fetch
    history
    httpie
    pipenv
    python
    pylint
    rsync
    sudo
    themes
    vi-mode
    web-search
    )

source $ZSH/oh-my-zsh.sh

autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

[[ -n "${key[Up]}"   ]] && bindkey -- "${key[Up]}"   up-line-or-beginning-search
[[ -n "${key[Down]}" ]] && bindkey -- "${key[Down]}" down-line-or-beginning-search

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
# The following lines were added by compinstall

zstyle ':completion:*' completer _list _oldlist _expand _complete _ignored _match _correct _approximate _prefix
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle :compinstall filename '/home/mesmer/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory autocd extendedglob
unsetopt beep
bindkey -e
# End of lines configured by zsh-newuser-install
alias vim="nvim"
alias pydoc="python -m pydoc"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

vicd()
{
    local dst="$(command vifm --choose-dir - "$@")"
    if [ -z "$dst" ]; then
        echo 'Directory picking cancelled/failed'
        return 1
    fi
    cd "$dst"
}
alias vifm=vicd
export PYENV_ROOT="${HOME}/.pyenv"

if [ -d "${PYENV_ROOT}" ]; then
    export PATH="${PYENV_ROOT}/bin:${PATH}"
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
fi
#bindkey -v
#

# tabtab source for packages
# uninstall by removing these lines
[[ -f ~/.config/tabtab/__tabtab.zsh ]] && . ~/.config/tabtab/__tabtab.zsh || true
