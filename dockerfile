FROM alpine:latest
RUN apk add --no-cache --update alpine-sdk rtl-sdr git cmake librtlsdr-dev bash

WORKDIR /usr/local/

RUN echo 'blacklist dvb_usb_rtl28xxu' > /etc/modprobe.d/blacklist-dvb_usb_rtl28xxu.conf
RUN git clone https://github.com/osmocom/rtl-sdr.git 
RUN mkdir /usr/local/rtl-sdr/build
RUN cd /usr/local/rtl-sdr/build
RUN cmake /usr/local/rtl-sdr/ -DINSTALL_UDEV_RULES=ON -DETACH_KERNEL_DRIVER=ON
RUN make 
RUN make install 
# RUN echo '/usr/local/lib' >> /etc/ld.so.conf
RUN ldconfig /usr/local
# WORKDIR /bin
# CMD ["/rtl_test -t"]