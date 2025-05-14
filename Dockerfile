# Use a lightweight Python base image
FROM python:3.9-slim

# Set the working directory inside the container
WORKDIR /app

# Install required system packages and MySQL development libraries
RUN apt-get update && apt-get install -y \
    gcc \
    build-essential \
    libmariadb-dev \
    pkg-config \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements file into the container
COPY requirements.txt .

# Upgrade pip and install Python dependencies
RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt

# Copy application code into the container
COPY . .

# Expose the application's port
EXPOSE 5000

# Run the app using Gunicorn
CMD ["gunicorn", "-b", "0.0.0.0:5000", "app:app"]
