# Avoid Mysql Installation Prompt
#sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password rapadura'
#sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password rapadura'

# Language Settings
export LANGUAGE=pt_BR.UTF-8
export LANG=pt_BR.UTF-8
export LC_ALL=pt_BR.UTF-8
locale-gen en_US.UTF-8
locale-gen pt_BR.UTF-8

aptitude update && aptitude safe-upgrade -y

# Install basic unix packages
aptitude install -y \
  bash-completion \
  build-essential \
  curl \
  git \
  postgresql \
  libxslt1-dev \
  libxml2-dev \
  libpq-dev \
  nodejs \
  nodejs-dev \
  tmux \
  vim \
  wget \
  rake \
  s3cmd \
  imagemagick \
  graphviz \
  htop

# Remove default ruby
aptitude purge ruby -y

# Install rvm and ruby
su -c 'gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3' vagrant
su -c 'curl -sSL https://get.rvm.io | bash -s stable' vagrant
su -c '/home/vagrant/.rvm/bin/rvm reload' vagrant
su -c 'echo "export rvm_max_time_flag=20" >> ~/.rvmrc' vagrant
su -c '/home/vagrant/.rvm/bin/rvm install 2.2.0' vagrant
su -c '/home/vagrant/.rvm/bin/rvm use 2.2.0 --default' vagrant
su -c '/home/vagrant/.rvm/bin/rvm all do gem install bundle' vagrant

# Create mysql database
#su -c "echo 'CREATE DATABASE sesai-pdsi' | mysql -u root -p'rapadura'"

# Copy postgresql config files to proper dir
#DIR="$(pwd)/sandbox/sesai-pdsi"
#sudo su -c "cp ${DIR}/samples/pg_hba.conf /etc/postgresql/9.3/main/" vagrant
#sudo su -c "cp ${DIR}/samples/postgresql.conf /etc/postgresql/9.3/main/" vagrant

# Create postgresql user and database
sudo su - postgres -c "echo \"CREATE USER desenv WITH SUPERUSER CREATEDB CREATEROLE ENCRYPTED PASSWORD 'rapadura';\" |psql -U postgres -d postgres" vagrant
sudo su - postgres -c "echo \"CREATE DATABASE on_stage;\" |psql -U postgres -d postgres" vagrant
sudo su - postgres -c "echo \"GRANT ALL PRIVILEGES ON DATABASE on_stage TO desenv;\" |psql -U postgres -d postgres" vagrant
