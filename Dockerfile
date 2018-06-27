# Base image built from: https://github.com/resin-io-playground/movidius-rpi3-baseimage
FROM shaunmulligan/movidius-rpi3-base:latest

COPY . .

CMD ["bash", "start.sh"]