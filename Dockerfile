FROM ruby:3.2.0

MAINTAINER Rodrigo VDB "rodrigovdb@gmail.com"

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -

ENV INSTALL_PATH /var/app
RUN mkdir -p $INSTALL_PATH

ENV RAILS_ENV='development'
ENV RAKE_ENV='development'

# ## Production mode
# ENV RAILS_ENV='production'
# ENV RAKE_ENV='production'

WORKDIR $INSTALL_PATH

COPY .env Gemfile* $INSTALL_PATH/
RUN bundle install --jobs 20

# Adding project files
# COPY . /app_name
# RUN bundle exec rake assets:precompile

EXPOSE 3000

CMD ["bundle", "exec", "puma", "-p", "3000", "-C", "config/puma.rb"]
