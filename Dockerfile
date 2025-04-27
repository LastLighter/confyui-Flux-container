FROM ghcr.io/saladtechnologies/comfyui-api:comfy0.3.29-api1.8.3-torch2.6.0-cuda12.4-runtime

# 设置环境变量
ENV BASE=""
ENV MODEL_DIR="/opt/ComfyUI/models"

# 添加构建参数接收令牌
ARG HF_TOKEN=""

# 安装 wget
RUN apt-get update && apt-get install -y wget && \
    rm -rf /var/lib/apt/lists/*

# 预构建目录
RUN mkdir -p ${MODEL_DIR}/{loras,vaes,text_encoders,diffusion_models}

# 下载模型文件
RUN  wget --header="Authorization: Bearer ${HF_TOKEN}" https://huggingface.co/comfyanonymous/flux_text_encoders/resolve/main/clip_l.safetensors -O ${MODEL_DIR}/text_encoders/clip_l.safetensors && \
     wget --header="Authorization: Bearer ${HF_TOKEN}" https://huggingface.co/black-forest-labs/FLUX.1-dev/resolve/main/flux1-dev.safetensors -O ${MODEL_DIR}/diffusion_models/flux1-dev.safetensors && \
     wget --header="Authorization: Bearer ${HF_TOKEN}" https://huggingface.co/black-forest-labs/FLUX.1-schnell/resolve/main/ae.safetensors -O ${MODEL_DIR}/vaes/ae.safetensors && \
     wget --header="Authorization: Bearer ${HF_TOKEN}" https://huggingface.co/comfyanonymous/flux_text_encoders/resolve/main/t5xxl_fp16.safetensors -O ${MODEL_DIR}/text_encoders/t5xxl_fp16.safetensors; \