#!/usr/bin/env bash
# bootstrap my environment on any fresh install. Feel free to modify to you needs
set -euo pipefail
user="mark"
dotfiles_repo="https://codeberg.org/m_a_r_k/dotfiles.git"

packages=(
base
base-devel
devtools
fzf
neovim
python-pynvim
ranger
stow
sudo
tmux
zsh
openssl
man
)

dev_packages=(
ansible
aspnet-runtime
bat
devtools
docker
docker-buildx
dotnet-runtime
dotnet-sdk
helm
kubectl
kubie
python-pywinrm
ripgrep
)

dev_aur=(
kubecolor
omnisharp-roslyn
helm-ls
wishlist
)
wsl_aur=(
wsl2-ssh-agent
wslu
)

echo "-----------------------------------------------"
echo "--------------------Mark's Arch Linux Bootstrap"
echo "-----------------------------------------------"
if (( EUID != 0))
then 
	echo "Running not as root"
	return 1
fi
echo "-----------------------------------------------"
echo "-------------------------------Option selection"
echo "-----------------------------------------------"
read -rsp "User password?" password
echo 
read -p "Install Dev Packages? (y/n): " installDev
read -p "Install WSL Packages? (y/n): " installWSL
read -p "Install AUR Packages? (y/n): " installAUR

echo "-----------------------------------------------"
echo "---------------------------------Updating repos"
echo "-----------------------------------------------"
pacman-key --init
pacman -Syu --noconfirm


echo "-----------------------------------------------"
echo "-------------------Installing official packages"
echo "-----------------------------------------------"
pacman -S "${packages[@]}" --noconfirm
if [ "$installDev" != "${installDev#[Yy]}" ] 
then
	pacman -S "${dev_packages[@]}" --noconfirm
fi

echo "-----------------------------------------------"
echo "----------------------------------Creating user"
echo "-----------------------------------------------"
if ! id -u "$user" >/dev/null 2>&1
then
	useradd -m -G wheel -s /usr/sbin/zsh "$user"
fi
echo "$user:$(openssl passwd -6 $password)" | chpasswd -e
# turn off passwd auth for the length of script
echo '%wheel ALL=(ALL:ALL) NOPASSWD: ALL' > /etc/sudoers.d/10_wheel

if [ "$installAUR" != "${installAUR#[Yy]}" ]
then
	if [ ! command -v paru &> /dev/null ]
	then
		echo "-----------------------------------------------"
		echo "--------------------------------Installing paru"
		echo "-----------------------------------------------"
		pacman -S --needed --noconfirm cargo
		sudo -iu "$user" mkdir -p "/home/$user/source"
		sudo -iu "$user" git clone https://aur.archlinux.org/paru.git "/home/$user/source/paru"
		cd "/home/$user/source/paru"
		sudo -u "$user" makepkg
		pacman -U --noconfirm ./*.pkg.tar.*
	fi

	echo "-----------------------------------------------"
	echo "------------------------Installing AUR packages"
	echo "-----------------------------------------------"
	if [ "$installDev" != "${installDev#[Yy]}" ] 
	then
		sudo -iu "$user" paru -S --noconfirm "${dev_aur[@]}"  
	fi
	if [ "$installWSL" != "${installWSL#[Yy]}" ] 
	then
		sudo -iu "$user" paru -S --noconfirm "${wsl_aur[@]}"
	fi
fi


if  [ ! -d "/home/$user/dotfiles" ]
then
echo "-----------------------------------------------"
echo "-------------------------------Cloning dotfiles"
echo "-----------------------------------------------"
	sudo -u "$user" git clone "$dotfiles_repo" /home/"$user"/dotfiles
fi

echo "-----------------------------------------------"
echo "-------------------------------Stowing dotfiles"
echo "-----------------------------------------------"
cd "/home/$user/dotfiles"
sudo -u "$user" stow nvim pathscripts tmux zsh git

echo "-----------------------------------------------"
echo "--------------------------Adding neovim plugins"
echo "-----------------------------------------------"
sudo -u "$user" curl -fLo "$/home/$user/.local/share/nvim/site/autoload/plug.vim" --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
sudo -u "$user" nvim -c "PlugInstall" -c "qa"
echo "-----------------------------------------------"
echo "----------------------------------------Cleanup"
echo "-----------------------------------------------"
echo '%wheel ALL=(ALL:ALL) ALL' > /etc/sudoers.d/10_wheel

echo "-----------------------------------------------"
echo "-----------------------------Bootstrap complete"
echo "-----------------------------------------------"
echo "login as $user and enjoy!" 





# Soli Deo Gloria
