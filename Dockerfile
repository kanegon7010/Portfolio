FROM ruby:2.6.6

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update -qq && apt-get install -y vim nodejs yarn npm && npm install n -g && n 12.13.0
RUN mkdir /myapp
WORKDIR /myapp

COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock

ENV APP_PATH=/myapp 
ENV BUNDLE_PATH=$APP_PATH/vendor/bundle
ENV PATH=$APP_PATH/vendor/bin:$PATH
RUN bundle config path $BUNDLE_PATH  \
    &&bundle binstubs --path=$APP_PATH/vendor/bin ; exit 0

COPY . /myapp

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["bundle","exec","rails", "server", "-b", "0.0.0.0"]