FROM ubuntu:22.04

# Avoid prompts
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && apt-get install -y \
    bash \
    curl \
    ca-certificates \
    libatomic1 \
    libgomp1 \
    && rm -rf /var/lib/apt/lists/*

# Run the installer
RUN curl -fsSL https://lmstudio.ai/install.sh | bash

# Set default arguments
ENV LMS_BIND="0.0.0.0"
ENV LMS_CONTEXT_SIZE="15000"
ENV LMS_GPU_USAGE="max"
ENV LMS_MODEL="google/gemma-4-26b-a4b"

EXPOSE 1234

# Ensure the model directory exists
VOLUME ["/root/.cache/lmstudio"]

# Use the ABSOLUTE PATH to the lms binary
# /root/.cache/lmstudio/bin/lms
CMD ["/bin/bash", "-c", "\
    /root/.lmstudio/bin/lms daemon up && echo 'Grabbing Model' && \
    /root/.lmstudio/bin/lms get ${LMS_MODEL} && echo 'Loading Model' && \
    /root/.lmstudio/bin/lms load ${LMS_MODEL} --gpu ${LMS_GPU_USAGE} --context-length ${LMS_CONTEXT_SIZE} && echo 'Starting Server' && \
    /root/.lmstudio/bin/lms server start --bind ${LMS_BIND} && echo 'Following Logs' && \
    /root/.lmstudio/bin/lms log stream"]
