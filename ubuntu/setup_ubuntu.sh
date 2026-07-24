# Nvim
# Download the x86_64 archive
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz

# Extract it to /opt
sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz

# Create a link to the new x86_64 binary
sudo ln -s /opt/nvim-linux-x86_64/bin/nvim /usr/local/bin/nvim

# zsh
sudo apt install zsh -y

# Oh my zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# P10k
# Font
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts

curl -LO https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf

curl -LO https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf

curl -LO https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf

curl -LO https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf

fc-cache -f -v
cd ~

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc
source .zshrc
sudo rm -rf powerlevel10k

