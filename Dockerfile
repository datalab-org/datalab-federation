FROM python:3.12-alpine AS builder
RUN apk add --no-cache make jq
WORKDIR /opt
RUN pip install uv
RUN uv venv
COPY requirements.txt .
RUN uv pip install -r requirements.txt
WORKDIR /app
COPY Makefile schema.yaml ./
COPY src src
RUN source /opt/.venv/bin/activate && make all

FROM alpine AS final

WORKDIR /app
COPY --from=builder /app/combined.yaml .
