FROM ubuntu:latest
RUN apt update
RUN apt install -y git python3-dev python3-pip redis-server
RUN apt install -y software-properties-common
#RUN apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xF1656F24C74CD1D8
#RUN add-apt-repository 'deb [arch=amd64,i386,ppc64el] http://ftp.ubuntu-tw.org/mirror/mariadb/repo/10.3/ubuntu xenial main'
RUN apt-get update
RUN apt-get install -y mariadb-server
# RUN mysql_secure_installation
RUN apt-get install -y mariadb-client-10.6
RUN apt-get install -y curl wget make cmake 
RUN echo " \
[mysqld] \
character-set-client-handshake = FALSE \
character-set-server = utf8mb4 \
collation-server = utf8mb4_unicode_ci \
\
[mysql] \
default-character-set = utf8mb4 \
" >> /etc/mysql/my.cnf
RUN DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt-get install -y xvfb libfontconfig wkhtmltopdf python3.10-venv
RUN apt install -y vim
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN addgroup --gid 1024 developer
RUN adduser --disabled-password --gecos "" --force-badname --ingroup developer dev 

RUN chmod 775 /home/dev
RUN chown -R dev:developer /home/dev
RUN chmod g+s /home/dev

RUN chsh --shell /usr/bin/bash dev

USER dev
WORKDIR /home/dev
#RUN service mysql restart
RUN curl -o-  https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | /usr/bin/bash 
# RUN cat /root/.nvm/Dockerfile
RUN echo "export PATH=\${PATH}:/home/dev/bin:/home/dev/.local/bin" >> .bashrc
RUN export NVM_DIR=$HOME/.nvm && \
	   [ -s $NVM_DIR/nvm.sh ] && . $NVM_DIR/nvm.sh && [ -s $NVM_DIR/bash_completion ] && \
		. $NVM_DIR/bash_completion && \
		nvm install 14 && \
		node -v && \
		npm install -g yarn 
RUN pip3 install frappe-bench
RUN mkdir -p ~/bin
RUN mkdir -p ~/ws

CMD ./bin/setup-frappe.sh

