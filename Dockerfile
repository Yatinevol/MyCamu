# Use official Python slim image
FROM python:3.10-slim

# Set the working directory in the container
WORKDIR /app

# Install system dependencies (fix for OpenCV + QR libs)
RUN apt-get update && apt-get install -y \
    libgl1 \
    libglib2.0-0 \
    libzbar0 \
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy application code
COPY . .

# Expose Flask port
EXPOSE 5000

# Command to run the Flask app
CMD ["python", "app.py"]
