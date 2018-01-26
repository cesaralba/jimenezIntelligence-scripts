FROM dockerhub.hi.inet/dcip/minimal:7

RUN yum -y update \
 && yum -y install rh-python36 \
 && yum clean all && rm -rf /var/cache/yum

RUN /opt/rh/rh-python36/root/usr/bin/python3.6 -mvenv /opt/delivenv 
COPY requirements.txt /opt/delivenv
RUN /bin/bash -c ". /opt/delivenv/bin/activate ; pip install -r /opt/delivenv/requirements.txt"


