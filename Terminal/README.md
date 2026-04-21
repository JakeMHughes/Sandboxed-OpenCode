# Terminal LLM Assistant

A simple bash script to send one-off questions to an LM Studio instance.

## Usage

```bash
./ask-llm.sh "How do I list files by size?"
```

### Alias
To use `??` as a shortcut, add this to your `.bashrc` or `.zshrc`:
```bash
alias '??'='/path/to/AI-Tools/Terminal/ask-llm.sh'
```


## Configuration

The script uses environment variables for configuration. If not provided, it uses the defaults listed below:

| Variable | Default Value | Description |
|----------|----------------|-------------|
| `LLM_HOST` | `192.168.0.135` | IP address of the host running LM Studio |
| `LLM_ENDPOINT` | `/v1/chat/completions` | API endpoint path |
| `LLM_MODEL` | `qwen/qwen3.5-9b` | Model identifier |

Example with custom host:
```bash
LLM_HOST=127.0.0.1 ./ask-llm.sh "What is the meaning of life?"
```

## Dependencies
- `curl`
- `jq`
