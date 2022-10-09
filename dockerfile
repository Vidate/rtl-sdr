FROM alpine:latest
RUN apk add --no-cache --update alpine-sdk rtl-sdr git cmake librtlsdr-dev bash

WORKDIR /usr/local/
RUN echo 'blacklist dvb_usb_rtl28xxu' > /etc/modprobe.d/rtl-sdr-blacklist.conf
RUN echo 'blacklist rtl2832' > /etc/modprobe.d/rtl-sdr-blacklist.conf
RUN echo 'blacklist rtl2830' > /etc/modprobe.d/rtl-sdr-blacklist.conf

RUN git clone https://github.com/osmocom/rtl-sdr.git
RUN cp rtl-sdr/rtl-sdr.rules /etc/udev/rules.d/
RUN mkdir /usr/local/rtl-sdr/build
RUN cd /usr/local/rtl-sdr/build
RUN cmake /usr/local/rtl-sdr/ -DINSTALL_UDEV_RULES=ON -DDETACH_KERNEL_DRIVER=ON
RUN make 
RUN make install
RUN echo '/usr/local/lib' >> /etc/ld.so.conf
RUN ldconfig /usr/local/lib