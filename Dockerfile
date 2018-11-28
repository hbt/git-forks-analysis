FROM ubuntu:16.04

#// TODO(hbt) ENHANCE optimize

RUN apt-get update && apt-get install -y git
RUN apt-get update && apt-get install -y python python-pip

RUN mkdir /deps && cd /deps && \ 
  git clone https://github.com/frost-nzcr4/find_forks

RUN cd /deps/find_forks && pip install -r requirements-prod.txt

#// TODO(hbt) NEXT testing rm
RUN mkdir /tests && cd /tests && git clone https://github.com/hbt/mouseless 

RUN apt-get install -y curl gawk  autoconf  automake  bison  libffi-dev  libgdbm-dev  libncurses5-dev  libsqlite3-dev  libtool  libyaml-dev  pkg-config  sqlite3  zlib1g-dev  libgmp-dev  libreadline6-dev  libssl-dev
RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB && curl -sSL https://get.rvm.io | bash -s stable --ruby=2.1.3

RUN cd /deps && git clone https://github.com/hbt/github-backup 

#// TODO(hbt) NEXT optimize

RUN /bin/bash -l -c "rvm use 2.1.3"
RUN /bin/bash -l -c "gem install bundler --no-ri --no-rdoc"
RUN /bin/bash -l -c "cd /deps/github-backup && bundle"
#RUN /bin/bash -l -c "ruby /deps/github-backup/bin/github-backup -u frost-nzcr4 -r find_forks -o /deps -f "
#https://github.com/frost-nzcr4/find_forks


#RUN cd /deps && git clone https://github.com/hbt/github-backup 
#RUN cd /deps/github-backup && bundle 

RUN apt-get install -y php

RUN cd / && git clone https://github.com/hbt/gitinspector

RUN apt-get install -y locales


RUN echo "LC_ALL=en_US.UTF-8" >> /etc/environment && \
  echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen && \
  echo "LANG=en_US.UTF-8" > /etc/locale.conf && \
  locale-gen en_US.UTF-8
  
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8
  
RUN cd /deps && git clone https://github.com/hbt/git_stats
RUN /bin/bash -l -c "rvm use 2.1.3 && cd /deps/git_stats && bundle"

ENV PATH="/git-forks-analysis/bin:${PATH}"
ADD . /git-forks-analysis
ADD ./config/php.ini /etc/php/7.0/cli/php.ini


#// TODO(hbt) NEXT testing rm
#RUN find-forks-recursively -u frost-nzcr4 -r find_forks -o /deps -f
#RUN cd /tests/mouseless && find-forks

