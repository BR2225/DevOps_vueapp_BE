# ---------- Stage 1: Builder ----------
FROM python:3.11-slim as builder

WORKDIR /app

RUN apt-get update && apt-get install -y \
      build-essential \
      libjpeg-dev \
      zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .
RUN pip install --no-cache-dir --prefix=/install -r requirements.txt

COPY . .

# ---------- Stage 2: Runtime ----------
FROM python:3.11-slim

WORKDIR /app

RUN apt-get update && apt-get install -y \
      libjpeg62-turbo \
      zlib1g \
    && rm -rf /var/lib/apt/lists/*

COPY --from=builder /install /usr/local
COPY --from=builder /app /app

EXPOSE 8000

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

CMD ["gunicorn", "streaming_backend.wsgi:application", "--bind", "0.0.0.0:8000"]
