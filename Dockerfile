FROM ubuntu:16.04



RUN apt-get update && apt-get install -y git python python-pip curl gawk  autoconf  automake  bison  libffi-dev  libgdbm-dev  libncurses5-dev  libsqlite3-dev  libtool  libyaml-dev  pkg-config  sqlite3  zlib1g-dev  libgmp-dev  libreadline6-dev  libssl-dev php locales

RUN echo "LC_ALL=en_US.UTF-8" >> /etc/environment && \
  echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen && \
  echo "LANG=en_US.UTF-8" > /etc/locale.conf && \
  locale-gen en_US.UTF-8
  
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8

# install ruby
RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB && curl -sSL https://get.rvm.io | bash -s stable --ruby=2.1.3

# clone deps and install
RUN mkdir /deps && cd /deps && \ 
  git clone https://github.com/frost-nzcr4/find_forks && \
  git clone https://github.com/hbt/github-backup && \
  git clone https://github.com/hbt/gitinspector && \
  git clone https://github.com/hbt/git_stats

RUN cd /deps/find_forks && pip install -r requirements-prod.txt

RUN /bin/bash -l -c "rvm use 2.1.3 && gem install bundler --no-ri --no-rdoc && cd /deps/github-backup && bundle"
RUN /bin/bash -l -c "rvm use 2.1.3 && cd /deps/git_stats && bundle"


ENV PATH="/git-forks-analysis/bin:${PATH}"
ADD ./config/php.ini /etc/php/7.0/cli/php.ini

