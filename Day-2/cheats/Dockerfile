FROM ruby:2.4.3

RUN apt-get update && \
    apt-get install -y nodejs

COPY Askbob/Gemfile* /Askbob/
WORKDIR /Askbob

RUN bundle install

COPY Askbob .

EXPOSE 3000
ENTRYPOINT ["bundle", "exec"]
CMD ["foreman", "start"]
