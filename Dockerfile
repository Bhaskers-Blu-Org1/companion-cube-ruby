FROM ruby:2.4
MAINTAINER Partner Ecosystem Team, IBM Digital Business Group <imcloud@ca.ibm.com>

RUN mkdir /src
WORKDIR /src

RUN gem update --system

COPY . /src

RUN bin/setup
