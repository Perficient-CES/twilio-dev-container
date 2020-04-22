FROM node:10-buster

RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    libsecret-1-dev \
    groff \
    less \
    bash-completion \
&& rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src/dev

ENV npm_config_user root

RUN npm install twilio-cli twilio-run create-twilio-function -g
RUN twilio plugins:install @twilio-labs/plugin-serverless
RUN twilio autocomplete bash --refresh-cache && printf "$(twilio autocomplete:script bash)" >> ~/.bashrc

RUN pip3 install virtualenv

EXPOSE 5566
