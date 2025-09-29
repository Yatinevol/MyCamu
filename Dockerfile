# Use an official Python runtime as a parent image
FROM python:3.10-slim

# Set the working directory in the container
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    libzbar0 \
    && rm -rf /var/lib/apt/lists/*

# Create and activate virtual environment
RUN python -m venv cammo
ENV PATH="cammo/bin:$PATH"

# Install Python dependencies inside the virtual environment
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt  # Use 'pip' instead of 'pip3' inside the venv

# Copy the rest of the application code
COPY . .

# Expose the correct port (default to 5000)
EXPOSE 5000

# Set the default command to run the app
CMD ["python3", "app.py"]
