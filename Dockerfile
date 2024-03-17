# Stage 1: Build the application
FROM python:3.9-slim-buster AS builder
ARG srcDir
WORKDIR /app
COPY $srcDir/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY $srcDir/run.py .
COPY $srcDir/app ./app

# Stage 2: Create final image with application and scanning capabilities
FROM alpine:latest
COPY --from=builder /app /app
RUN rm -rf /var/lib/apt/lists/*  # Clean up APT cache (optional)

# Vulnerability scanning (assuming Trivy is available in the environment)
COPY --from=aquasec/trivy:latest /usr/local/bin/trivy /usr/local/bin/trivy
RUN trivy rootfs --no-progress /

EXPOSE 5000

CMD ["gunicorn", "-b", "0.0.0.0:5000", "run:app"]
