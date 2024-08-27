FROM python:3.12-alpine AS builder

RUN apk add --no-cache make
WORKDIR /opt
RUN pip install uv
RUN uv venv
COPY requirements.txt .
RUN uv pip install -r requirements.txt

FROM builder AS runner

COPY --from=builder /opt /opt
WORKDIR /app
COPY Makefile schema.yaml ./
COPY src src

RUN source /opt/.venv/bin/activate && make all
