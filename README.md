# zenMiner
Easiest way to create a functional crypto miner with full control.
Installs drivers for both Nvidia and AMD.

Start of with a simple empty installation of Debian 10.
Easiest from Debian Live and choose install without any packages.

Start with:
```
apt update
apt upgrade
apt -y install openssh-server vim git screen

git clone --recurse-submodules -j8 git@github.com:jzenzen/zenMiner.git
```

Then use the script (which is not 100% tested)
```
cd zenMiner
.\install.sh
```

## Included miners
* xmrig (MoneroOcean version with coin algo benchmark)
* xmr-stak
* xmr-stak-rx
* Team Red Miner
* Gminer
* T-rex miner
