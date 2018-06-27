## A Basic example for Movidius NCS and RPI3 running a tensorflow model on resin.io

This example demonstrates how to run deploy and run a simple pretrained tensorflow model, in this case the [inception V3](https://arxiv.org/abs/1512.00567) model, on a stream of video data from the Raspberry Pi camera to enable realtime object recognition. It makes use of the [Movidius Neural Compute Stick](https://developer.movidius.com/) to accelerate the recognition.

### Deploying to a fleet of Raspberry Pis

- Create an account and an Application at resin.io, if you don't know how to do this, just check out the [Getting Started Guide](http://docs.resin.io/learn/getting-started/raspberrypi3/python/)
- Add the following to your [Fleet Configuration](https://docs.resin.io/learn/manage/configuration/#managing-fleet-configuration-variables) in your newly created Application.

| Configuration Name                | Value |
|-----------------------------------|-------|
| RESIN_HOST_CONFIG_start_x         | 1     |
| RESIN_HOST_CONFIG_gpu_mem         | 192   |
| RESIN_HOST_CONFIG_max_usb_current | 1     |
| RESIN_HOST_CONFIG_safe_mode_gpio  | 4     |

- Now provision your RPI devices into the Application, making sure to connect up the RPI camera module and the Movidius Compute Stick.
- `git push resin master` this repository to the git remote for the application you created.

### Deploying a Different Model

In order to deploy various models we first need to be able to compile our tensorflow or caffe models into a graph format that the movidius NCS stick understands. To do this we need to use the NCS toolkit (not installed on the RPI because its uncessary bloat), for this we can just pull down and run the full ubuntu image with the NCSDK toolkit installed. In our example below use the `ncappzoo` repo and mount it into the toolkit repo which will allow us to compile and test all the examples in repo.

```
git clone -b ncsdk2 https://github.com/movidius/ncappzoo.git
cd ncappzoo
docker run -v `pwd`:/ncappzoo -net=host --privileged -v /dev:/dev --name ncsdk -it shaunmulligan/movidius-x86-toolkit /bin/bash
```

Once we have the docker containeou need tor running, we can just runs `make all` at the top of the `/ncappzoo` folder and it will go away and compile all the models into graphs the movidius is capable of running. **NOTE** you need to have the movidius usb stick plugged into the machine you are running this container on.

Once all the models are compiled you can just navigate to the `ncappzoo` directory you cloned and you should be able to grab the various graphs from any of the examples, in the same why we did for the basic `inception v3` model. 

### Preview the Camera Image

If you want to check that you Pi is looking at the right things, you can put the application into preview mode by adding an Environment Variable called `PREVIEW` set with an value. This will cause the application to snap a still photo and the serve that photo on `<YOUR_DEVICE_IP>:8080/preview.jpg`

To return to recognition mode simply delete the `PREVIEW` variable on your dashboard.