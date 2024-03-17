# Stage 1: Build the application
FROM python:3.9-slim-buster AS builder

# Set working directory
WORKDIR /app

# Copy requirements.txt first to leverage caching
COPY ./requirements.txt .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the run.py script
COPY ./run.py .

# Copy the app directory
COPY ./app ./app

# Stage 2: Create final image with application and scanning capabilities
FROM alpine:latest

# Set working directory
WORKDIR /app

# Copy the built app from the builder stage
COPY --from=builder /app .

# Clean up APT cache (optional)
RUN rm -rf /var/lib/apt/lists/*

# Vulnerability scanning (assuming Trivy is available in the environment)
COPY --from=aquasec/trivy:latest /usr/local/bin/trivy /usr/local/bin/trivy
RUN trivy rootfs --no-progress /

# Expose port
EXPOSE 5000

# Run the application
CMD ["python", "run.py"]
