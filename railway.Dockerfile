# Railway-optimized Dockerfile for Langflow
FROM python:3.12-slim

# Set working directory
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    git \
    && rm -rf /var/lib/apt/lists/*

# Install uv for faster dependency management
RUN pip install --no-cache-dir uv==0.7.20

# Copy dependency files
COPY pyproject.toml uv.lock ./
COPY src/backend/base/pyproject.toml src/backend/base/
COPY src/lfx/pyproject.toml src/lfx/

# Install dependencies using uv (much faster than pip)
RUN uv pip install --system --no-cache -e .

# Copy application code
COPY . .

# Create data directory for SQLite (if using SQLite)
RUN mkdir -p /app/data/.cache/langflow

# Expose port (Railway will set PORT env var)
EXPOSE 7860

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=40s --retries=3 \
    CMD curl -f http://localhost:${PORT:-7860}/health_check || exit 1

# Start command (can be overridden by railway.toml)
CMD ["python", "-m", "langflow", "run", "--host", "0.0.0.0", "--port", "7860"]
