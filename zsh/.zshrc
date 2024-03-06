# zsh config
# Mark Hegreberg

# colors and prompts
autoload -U colors && colors
autoload -Uz promptinit
promptinit
export LC_ALL="en_US.UTF-8"
alias ls='ls --color=auto'
PROMPT='%F{red}%(?..%B(%?%)%b)%f%m%#' # if last command error, show error in red, then MachineName%
RPROMPT='%3~' # on the right, show working dir


# history control
HISTFILE=~/.cache/zsh/histfile
HISTSIZE=10000
SAVEHIST=10000
setopt extendedglob nomatch

# path
export PATH=~/scripts:$PATH
export PATH=~/.dotnet/tools:$PATH

# aliases
alias ':q'=exit
alias ':wq'=exit
alias 'ZZ'=exit

alias mkcd='. mkcd'
alias fcd='. fuzzycd'
alias work=tmux-session-template
alias psrun='Powershell.exe  -File'

# completion settings
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}'
zstyle :compinstall filename '/home/mark/.zshrc'
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)

# Vim mode
bindkey -v
export KEYTIMEOUT=1
# Vim nav in menus
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -v '^?' backward-delete-char
# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.




# program specific configs
if command -v nvim &> /dev/null
then 
	alias v=nvim
	alias vim=nvim
	alias n=nvim
	alias nv=nvim
fi 

if command -v git &> /dev/null
then 
	alias g=git
	alias G=git
	alias gf='git fugitive'
	alias gs='git status'
fi

if command -v tmux &> /dev/null
then 
	alias t=tmux
	alias tend='tmux kill-session && tmux attach'
fi

if command -v dotnet &> /dev/null
then 
	
	# opt out of telemetry
	export DOTNET_CLI_TELEMETRY_OPTOUT=1
	# make entity framework calm down
	export DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=0
	export DOTNET_SYSTEM_GLOBALIZATION_PREDEFINED_CULTURES_ONLY=0:
	export CLR_ICU_VERSION_OVERRIDE="71.1"
	# zsh parameter completion for the dotnet CLI
	
	_dotnet_zsh_complete()
	{
	  local completions=("$(dotnet complete "$words")")
	
	  reply=( "${(ps:\n:)completions}" )
	}
	
	compctl -K _dotnet_zsh_complete dotnet

	alias dn=dotnet
	alias dnb='dotnet build'
	alias dr='dotnet run'
	alias dr1='dotnet run --urls="http://localhost:7101;https://localhost:7100"'
	alias dr2='dotnet run --urls="http://localhost:7201;https://localhost:7200"'
	alias dr3='dotnet run --urls="http://localhost:7301;https://localhost:7300"'
	alias dr4='dotnet run --urls="http://localhost:7401;https://localhost:7400"'
	alias dr5='dotnet run --urls="http://localhost:7501;https://localhost:7500"'
	alias dw1='dotnet watch run --urls="http://localhost:7101;https://localhost:7100"'
	alias dw2='dotnet watch run --urls="http://localhost:7201;https://localhost:7200"'
	alias dw3='dotnet watch run --urls="http://localhost:7301;https://localhost:7300"'
	alias dw4='dotnet watch run --urls="http://localhost:7401;https://localhost:7400"'
	alias dw5='dotnet watch run --urls="http://localhost:7501;https://localhost:7500"'
	alias dnef='dotnet ef'
	alias fastef='dotnet ef --no-build'
	alias dnup='dotnet list package --outdated'
	alias dnap='dotnet add package'
fi

if command -v docker &> /dev/null
then
	alias dk=docker
fi

if command -v kubecolor &> /dev/null
then
	export KUBE_EDITOR=nvim

	alias kubectl=kubecolor
	alias kc=kubecolor
	alias kcuc='kubectl config use-context'
	alias kcs='kubectl config current-context && kubectl get nodes && kubectl get pods'
	source <(kubectl completion zsh)
	compdef kubecolor=kubectl

elif command -v kubectl &> /dev/null
then
	export KUBE_EDITOR=nvim

	alias kc=kubectl
	alias kcuc='kubectl config use-context'
	alias kcs='kubectl config current-context && kubectl get nodes && kubectl get pods'
	source <(kubectl completion zsh)
fi

if command -v ruby &> /dev/null
then
	# ruby
	export GEM_HOME="$(ruby -e 'puts Gem.user_dir')"
	export PATH="$PATH:$GEM_HOME/bin"
fi




#local environment specific configs
touch ~/.zshrc.local
source ~/.zshrc.local

#other sources
source ~/.local/share/zsh/highlighting/zsh-syntax-highlighting.zsh
