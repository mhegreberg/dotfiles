if command -v wsl2-ssh-agent >/dev/null 2>&1;
then
	eval "$(wsl2-ssh-agent)"
	export GPG_TTY=$(tty)
	gpgconf --launch gpg-agent
	gpg-connect-agent updatestartuptty /bye >/dev/null
elif [[ -d "$HOME/.gnupg" ]];
then
	export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
	export GPG_TTY=$(tty)
	gpgconf --launch gpg-agent
	gpg-connect-agent updatestartuptty /bye >/dev/null
fi
