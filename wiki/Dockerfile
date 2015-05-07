FROM ubuntu

MAINTAINER Will Childs-Klein <will.childsklein@gmail.com>

# install dependencies and a few tools
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y \
    python \
    python-pip \
    curl \
    git

# fine ALL the bins
ENV PATH /usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin

# add code and set workdir
ADD . /wiki

# install dependencies
RUN pip install -r /wiki/requirements.txt

# expose port and set workdir
EXPOSE 80
WORKDIR /wiki

# run that ish
CMD gunicorn -b 127.0.0.1:80 app:app
