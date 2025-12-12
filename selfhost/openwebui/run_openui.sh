#!/bin/bash

export WEBUI_AUTH=false
export UVICORN_WORKERS=1
export DATA_DIR=$PWD/data
export ENV=prod

export RAG_EMBEDDING_ENGINE=ollama
export THREAD_POOL_SIZE=1
export BYPASS_EMBEDDING_AND_RETRIEVAL=true

export AUDIO_STT_ENGINE=openai
export AUDIO_TTS_ENGINE=

export ENABLE_FOLLOW_UP_GENERATION=false
export ENABLE_CODE_EXECUTION=false
export ENABLE_CODE_INTERPRETER=false
export ENABLE_AUTOCOMPLETE_GENERATION=false
export ENABLE_EVALUATION_ARENA_MODELS=false
export ENABLE_MESSAGE_RATING=false
export ENABLE_COMMUNITY_SHARING=false
export ENABLE_TAGS_GENERATION=false
export SAFE_MODE=true
export ENABLE_RETRIEVAL_QUERY_GENERATION=false
export ENABLE_WEB_SEARCH=false
export ENABLE_IMAGE_GENERATION=false
export ENABLE_OLLAMA_API=False

export OFFLINE_MODE=True

source .env

export OPENAI_API_BASE_URL=https://openrouter.ai/api/v1
export OPENAI_API_KEY=$openrouter_key


export RAG_EMBEDDING_MODEL=

open-webui serve --port 2999 --host "localhost"
