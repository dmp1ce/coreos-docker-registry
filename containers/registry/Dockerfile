FROM base/arch
MAINTAINER David Parrish <daveparrish@gmail.com>

RUN pacman -Syu --noconfirm

# Install yaourt for AUR packages
RUN echo -e "[archlinuxfr]\nSigLevel = Never\nServer = http://repo.archlinux.fr/\$arch" >> /etc/pacman.conf
RUN pacman -Sy --noconfirm base-devel yaourt

# Install requirements for repository
RUN ln -s /proc/self/fd /dev/fd	# Fixes error with missing /dev/fd
RUN yaourt -S --noconfirm git python2-pip python2-boto libevent gunicorn

RUN cd /; git clone https://github.com/dotcloud/docker-registry.git
RUN cp --no-clobber /docker-registry/config/config_sample.yml /docker-registry/config/config.yml
RUN cd /docker-registry; pip2 install -r requirements.txt

# Define configuration file in a persistant volume
RUN mkdir /data && mv /docker-registry/config/config.yml /data && ln -s /data/config.yml /docker-registry/config
# && ln -s /data/config.yml /docker-registry
VOLUME ["/data"]

EXPOSE 5000

WORKDIR /docker-registry
#ENTRYPOINT gunicorn --access-logfile - --log-level debug --debug -b 0.0.0.0:5000 -w 1 wsgi:application
ENTRYPOINT ./run.sh
