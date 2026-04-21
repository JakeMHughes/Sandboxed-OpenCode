#!/bin/bash

# Configuration with defaults
HOST="${LLM_HOST:-192.168.0.135}"
ENDPOINT="${LLM_ENDPOINT:-/v1/chat/completions}"
MODEL="${LLM_MODEL:-qwen/qwen3.5-9b}"

# The system prompt defines the behavior
SYSTEM_PROMPT="You are a terminal assistant. If the user asks for a shell command, provide the specific shell command. Return ONLY the command, no prose, no backticks, unless an explanation is absolutely necessary for safety. Otherwise answer as you normally would."
USER_QUERY="$1"

curl -s "http://${HOST}:1234${ENDPOINT}" \
  -H "Content-Type: application/json" \
  -d "$(jq -n \
    --arg model "$MODEL" \
    --arg sys "$SYSTEM_PROMPT" \
    --arg user "$USER_QUERY" \
    '{model: $model, messages: [{role: "system", content: $sys}, {role: "user", content: $user}]}')" \
  | jq -r '.choices[0].message.content'
