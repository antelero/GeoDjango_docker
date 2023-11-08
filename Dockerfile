###
#https://github.com/docker/awesome-compose/tree/master/official-documentation-samples/django/#define-the-project-components
###
# FROM directive instructing base image to build upon
FROM python:3.10.13-alpine3.18

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Install project dependencies

RUN apk RUN apk update \
  # psycopg2 dependencies
  && apk add --virtual build-deps gcc python3-dev musl-dev \
  && apk add postgresql-dev \
  # Pillow dependencies
  && apk add jpeg-dev zlib-dev freetype-dev lcms2-dev openjpeg-dev tiff-dev tk-dev tcl-dev \
  # CFFI dependencies
  && apk add libffi-dev py-cffi \
  # Translations dependencies
  && apk add gettext \
  # https://docs.djangoproject.com/en/dev/ref/django-admin/#dbshell
  && apk add postgresql-client
  #for geodjango

RUN apk add --no-cache --virtual .build-deps-edge \
        --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing \
        --repository http://dl-cdn.alpinelinux.org/alpine/edge/main \
        gdal-dev \
        geos-dev \        
        proj-dev    
        #Reemplazo de  proj-dev a proj4-dev       

RUN pip install --upgrade pip exit

# Set the working directory in the container
WORKDIR /code
COPY requirements.txt /code/
RUN pip install -r requirements.txt
COPY . /code/