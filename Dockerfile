# Use an official Python image
FROM python:3.9-slim

# Install system dependencies (example: libsndfile, fluidsynth, etc.)
RUN apt-get update && apt-get install -y \
    libsndfile1 \
    fluidsynth \
    && rm -rf /var/lib/apt/lists/*

# Create app directory
WORKDIR /app

# Copy requirements and install
COPY requirements.txt /app
RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt

# Copy source code
COPY . /app

# Expose port
EXPOSE 8080

# Start Flask via gunicorn
CMD ["gunicorn", "--bind", "0.0.0.0:8080", "main:app"]
