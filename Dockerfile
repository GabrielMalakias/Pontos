FROM elixir:latest


# Install debian packages
RUN apt-get update
RUN apt-get install --yes build-essential inotify-tools postgresql-client

# Install Phoenix packages
RUN mix local.hex --force
RUN mix local.rebar --force
RUN wget https://github.com/phoenixframework/archives/raw/master/phx_new.ez
RUN mix archive.install ./phx_new.ez

WORKDIR /app
EXPOSE 4000
