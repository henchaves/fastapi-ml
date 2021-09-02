FROM python:3.8.12-slim-buster
WORKDIR /usr/src/app

RUN apt-get -y update && apt-get install -y \
  python3-dev \
  apt-utils \
  python-dev \
  build-essential \
  && rm -rf /var/lib/apt/lists/*

RUN pip install --upgrade setuptools
RUN pip install \
  cython==0.29.24 \
  numpy==1.21.1 \
  pandas==1.3.1 \
  pystan==2.19.1.1 

COPY requirements.txt .
RUN pip install -r requirements.txt

COPY . .

CMD uvicorn main:app --reload --workers 1 --host 0.0.0.0 --port 8008