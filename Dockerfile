FROM shaunmulligan/movidius-rpi3-base:latest

COPY . .

CMD ["bash", "start.sh"]