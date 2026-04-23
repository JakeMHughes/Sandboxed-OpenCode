#!/bin/bash

# Configuration with defaults
HOST="${LLM_HOST:-https://llm.hughesportal.home}"
ENDPOINT="${LLM_ENDPOINT:-/v1/chat/completions}"
MODEL="${LLM_MODEL:-cyankiwi/Qwen3.5-9B-AWQ-BF16-INT8}"

# Determine OS
OS=$(uname)
case "$OS" in
  Linux*)  OS_NAME="Linux" ;;
  Darwin*) OS_NAME="macOS" ;;
  *)       OS_NAME="Unknown" ;;
esac

# The system prompt defines the behavior
SYSTEM_PROMPT="You are a terminal assistant for $OS_NAME. If the user asks for a shell command, provide the specific shell command for $OS_NAME. Return ONLY the command, no prose, no backticks, unless an explanation is absolutely necessary for safety. Otherwise answer as you normally would."
USER_QUERY="$*"

curl -s "${HOST}${ENDPOINT}" \
  -H "Content-Type: application/json" \
  -d "$(jq -n \
    --arg model "$MODEL" \
    --arg sys "$SYSTEM_PROMPT" \
    --arg user "$USER_QUERY" \
    '{model: $model, messages: [{role: "system", content: $sys}, {role: "user", content: $user}]}')" \
  | jq -r '.choices[0].message.content'
