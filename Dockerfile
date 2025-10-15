FROM python:3.8-slim

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    git \
    wget \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy dependency manifest and install
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

# Copy the application
COPY . /app

# Ensure assets directory exists (model will be downloaded there)
RUN mkdir -p /app/assets

EXPOSE 8000

# Use a simple startup command for uvicorn
CMD ["uvicorn", "sentiment_analyzer.api:app", "--host", "0.0.0.0", "--port", "8000"]
