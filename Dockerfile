FROM python:3.9-slim-buster

ARG srcDir=src
WORKDIR /app
COPY $srcDir/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY $srcDir/run.py .
COPY $srcDir/app ./app

FROM build AS vulnscan
COPY --from=aquasec/trivy:latest /usr/local/bin/trivy usr/local/bin/trivy
RUN trivy rootfs --no-progress /


EXPOSE 5000

CMD ["gunicorn", "-b", "0.0.0.0:5000", "run:app"]