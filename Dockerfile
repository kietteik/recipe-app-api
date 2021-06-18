FROM python:3.8-alpine

ENV PYTHONUNBUFFERRED 1

COPY ./requirements.txt /requirements.txt

RUN apk add --update --no-cache postgresql-client
RUN apk add --update --no-cache --virtual .build_deps \
    gcc libc-dev linux-headers postgresql-dev

RUN pip install -r /requirements.txt

RUN apk del .build_deps

RUN mkdir /app
WORKDIR /app
COPY ./app /app

RUN adduser -D user
USER user