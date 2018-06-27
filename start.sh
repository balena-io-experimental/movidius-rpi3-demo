#ensure /dev/video0 device is loaded
modprobe bcm2835-v4l2

if [ -n "${PREVIEW}" ]; then
    python3 cam-preview.py
    python3 -m http.server 8080
else
    # Launch classifier using Inception V3 model
    python3 live-image-classifier.py --graph inception/model/v3/graph --labels inception/model/v3/labels.txt --mean 127.5 --scale 0.00789 --dim 299 299 --colormode="RGB"
fi
