FROM python:2.7-slim

WORKDIR /app

RUN sed -i 's|http://deb.debian.org/debian|http://archive.debian.org/debian|g' /etc/apt/sources.list && \
    sed -i 's|http://security.debian.org/debian-security|http://archive.debian.org/debian-security|g' /etc/apt/sources.list && \
    echo 'Acquire::Check-Valid-Until "false";' > /etc/apt/apt.conf.d/99no-check-valid-until

RUN apt-get update && apt-get install -y \
    gcc \
    build-essential \
    libbluetooth-dev \
    git \
    && rm -rf /var/lib/apt/lists/*


COPY requirement.txt .
RUN pip install --no-cache-dir -r requirement.txt


COPY . .

EXPOSE 5000

RUN export PYTHONPATH=$PYTHONPATH:/usr/local/lib/python2.7/site-packages


CMD ["python", "main.py"]
