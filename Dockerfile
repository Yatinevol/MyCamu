# Use an official Python runtime as a parent image
FROM python:3.10-slim

# Set the working directory in the container
WORKDIR /app

# Install system dependencies (including libGL for OpenCV)
RUN apt-get update && apt-get install -y \
    libzbar0 \
    libgl1 \
    libglib2.0-0 \
    && rm -rf /var/lib/apt/lists/*

# Create and activate virtual environment
RUN python -m venv cammo
ENV PATH="cammo/bin:$PATH"

# Install Python dependencies inside the virtual environment
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application code
COPY . .

# Expose the correct port (default to 5000)
EXPOSE 5000

# Set the default command to run the app
CMD ["python", "app.py"]
