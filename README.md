# LiteLLM for GEMINI PRO proxy

Because Google Gemini Pro provides free api key, so we can use it as a proxy to serve projects that only support openai api.

## Prerequisites

- docker and docker-compose installed.

## Step 1.1: docker image build

- build docker image

```bash
docker build . -t ghcr.io/saqwed/litellm_gemini_pro_proxy:latest
```

## Step 1.2: Use pre-built image

You can choice to build docker image by yourself by following step 1.1, but if you don't wanna to, you can use pre-built image by github action.

```bash
docker pull ghcr.io/saqwed/litellm_gemini_pro_proxy:latest
```

## Step 2: .env file

- Create a .env file and fill in GEMINI PRO API KEY

The file should looks like below example:

```
GEMINI_API_KEY=your GEMINI PRO API key
```

- If you need to setup proxy, you can add

```
http_proxy=your proxy address
https_proxy=your proxy address
```

## Step 3: Launch it

```bash
docker-compose up -d
```

## Usage example

- gptcommit

```bash
cargo install --locked gptcommit
#goto git repo and run
gptcommit install
# get api server address and port from previous action
gptcommit config set openai.api_base http://your_ip_address:5678
```
