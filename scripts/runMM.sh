#!/bin/bash
export GMINER_COMMON="--server localhost:3333 --user 435a664C8oJTcH3mbAXLvUHQs5EJkonwrJ9jgKzfMNLRAaNVPB2AqBMdYj9wCZckPc9yyd153B983F6iaFmfg5QE267XQsC --pass zenMiner"
export GMINER_LAST="gminer/miner $GMINER_COMMON"
export GMINER_39="gminer39/miner $GMINER_COMMON"
#./meta-miner/mm.js -p=gulf.moneroocean.stream:11024 --ethash="./teamredminer-v0.8.0-linux/teamredminer -a ethash --eth_config=A472 --eth_4g_max_alloc=4072 -o stratum+tcp://127.0.0.1:3333 -u 435a664C8oJTcH3mbAXLvUHQs5EJkonwrJ9jgKzfMNLRAaNVPB2AqBMdYj9wCZckPc9yyd153B983F6iaFmfg5QE267XQsC -p gpu_miner" --c29s="$GMINER_LAST --algo cuckaroo29s" --c29b="$GMINER_LAST --algo cuckaroo29b" --c29v="$GMINER_39 --algo cuckarood29v" --kawpow="./xmrig/build/xmrig --config=config.json"
./meta-miner/mm.js -p=gulf.moneroocean.stream:11024 --ethash="./teamredminer-v0.8.0-linux/teamredminer -a ethash --eth_config=A472 --eth_4g_max_alloc=4072 -o stratum+tcp://127.0.0.1:3333 -u 435a664C8oJTcH3mbAXLvUHQs5EJkonwrJ9jgKzfMNLRAaNVPB2AqBMdYj9wCZckPc9yyd153B983F6iaFmfg5QE267XQsC -p gpu_miner" --kawpow="./xmrig/build/xmrig --config=config.json"

