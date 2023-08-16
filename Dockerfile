# syntax=docker/dockerfile:1
FROM python:3-alpine

RUN  addgroup -S tocos && adduser -S tocos -G tocos



# Set work directory
WORKDIR /usr/src/app

# Set environment variables
# Don't create bytecode file - saves disk
ENV PYTHONDONTWRITEBYTECODE 1
# Don't buffer stderr/stdout
ENV PYTHONUNBUFFERED 1

# install dependencies
RUN pip install --upgrade pip
COPY --chown=tocos:tocos ./tocos-api/requirements.txt /usr/src/app/requirements.txt

RUN pip install -r  /usr/src/app/requirements.txt

# copy project
COPY --chown=tocos:tocos ./tocos-api/*.py /usr/src/app/

USER tocos

# Run it
CMD ["gunicorn"  , "-b", "0.0.0.0:8300", "tocos-credits:app"]
