# ---------- Stage 1: Builder ----------
FROM python:3.11-slim as builder

# Set working directory
WORKDIR /app

# System deps for Pillow
RUN apt-get update && apt-get install -y \
      build-essential \
      libjpeg-dev \
      zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

# Install dependencies to a local dir (for copying later)
COPY requirements.txt .
RUN pip install --no-cache-dir --prefix=/install -r requirements.txt

# Copy project
COPY . .

# Collect static files
RUN python manage.py collectstatic --noinput


# ---------- Stage 2: Runtime ----------
FROM python:3.11-slim

WORKDIR /app

# Install only runtime system dependencies
RUN apt-get update && apt-get install -y \
      libjpeg62-turbo \
      zlib1g \
    && rm -rf /var/lib/apt/lists/*

# Copy installed python packages from builder stage
COPY --from=builder /install /usr/local

# Copy only project files (not venv, cache, etc.)
COPY --from=builder /app /app

# Expose app port
EXPOSE 8000

# Entrypoint (optional if you want migrations at runtime)
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

# Start Django with Gunicorn
CMD ["gunicorn", "streaming_backend.wsgi:application", "--bind", "0.0.0.0:8000"]
