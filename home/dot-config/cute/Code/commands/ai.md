# Llama Server

## ai - kill llama-cpp
```bash
pkill llama-server
```

# Models

## ai - Enoch-12b (abliterated)
```bash
notify-send -u low 'AI Model' 'Loading Enoch-12b' && pkill llama-server; llama-server -m ~/Code/models/Enoch-CWC-Mistral-Nemo-12B-v2-GGUF-q4_k_m.gguf -a 'Enoch-12b' --ctx-size 8192 --port 8081 --host 127.0.0.1
```
## ai - Gemma3-4b
```bash
notify-send -u low 'AI Model' 'Loading Gemma3-4b' && pkill llama-server; llama-server -a 'Gemma3-4b (vision)' -m ~/Code/models/ggml-org_gemma-3-4b-it-GGUF_gemma-3-4b-it-Q4_K_M.gguf --mmproj ~/Code/models/ggml-org_gemma-3-4b-it-GGUF_mmproj-model-f16.gguf --temp 1.0 --top-k 64 --min-p 0.00 --top-p 0.95 --repeat-penalty 1.0 --ctx-size 8192 --port 8081 --host 127.0.0.1
```
## ai - GPT-OSS-20b
```bash
notify-send -u low 'AI Model' 'Loading GPT-OSS-20B' && pkill llama-server; llama-server -a 'GPT-OSS-20b' -m ~/Code/models/gpt-oss-20b-MXFP4.gguf --jinja --ctx-size 8192 -ub 2048 -b 2048 --n-cpu-moe 21 --temp 1.0 --top-p 1.0 --top-k 0 --min-p 0 --port 8081 --host 127.0.0.1
```
## ai - LFM2-8B-A1B
```bash
notify-send -u low 'AI Model' 'Loading LFM2' && pkill llama-server; llama-server -a 'LFM2-8B-A1B' -m ~/Code/models/LFM2-8B-A1B-Q4_K_M.gguf --ctx-size 8192 --temp 0.3 --min-p 0.15 --repeat-penalty 1.05 --port 8081 --host 127.0.0.1
```
## ai - Qwen3-30b-A3B
```bash
notify-send -u low 'AI Model' 'Loading Qwen3-30B-A3B' && pkill llama-server; llama-server -a 'Qwen-30b-A3B' -m ~/Code/models/Qwen3-30B-A3B-Instruct-2507-Q4_K_M.gguf --ctx-size 8192 --temp 0.7 --top-p 0.8 --min-p 0 --top-k 20 --presence-penalty 1.05 --port 8081 --host 127.0.0.1
```
## ai - Qwen3-4b-instruct
```bash
notify-send -u low 'AI Model' 'Loading Qwen3-4B-Instruct' && pkill llama-server; llama-server -a 'Qwen3-4B-Instruct' -m ~/Code/models/Qwen3-4B-Instruct-2507-IQ4_XS.gguf --ctx-size 8192 --temp 0.7 --top-p 0.8 --top-k 20 --min-p 0 --presence-penalty 1.05 --port 8081 --host 127.0.0.1
```