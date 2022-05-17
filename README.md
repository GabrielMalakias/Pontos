# Pontos

## Overview

This app has a single endpoint that returns users. It's easily accessible by executing the following command:

```shell
# GET /
curl http://localhost:4000

{"timestamp":"2022-05-17T18:12:25.334970Z","users":[{"id":11501,"points":87},{"id":11973,"points":85}]}
```

## Installing

First install elixir, this project uses 1.13.4, there are many ways to do that for more details check some options like:

- https://asdf-vm.com/
- https://github.com/taylor/kiex

After installing elixir you can install the dependencies by running `mix deps.get`

This project requires postgres to run locally, to make that easier a docker-compose.yml is available in the project so the instance can be easily spawn by running `docker-compose up -d db`

After that run `./scripts/setup`, that will automatically create the db, migrate and seed with some values. It might take some minutes for to complete this process

Now run `./scripts/test` if its all green the application is fully set and can be started by running `./scripts/start`

## Considerations/Limitations

As you have already noticed it takes a little bit of time to create 1 Million records, that is because I'm seeding using `Task.async_stream`, as the number of threads and the DB capacity is limited. That was my first attempt to solve the challenge given. So as I didnt want to lose time tweaking the app to reach a better performance I just set the number of connections to 50, matching the number of threads when calling this process.

The second approach I tried was to use Postgres to generate random numbers to avoid hitting the DB for each update. That works for this app, but in case it was required to make it based on messages or something else it would not.

I like CQRS so I created "Commands" for each action possible, the app only needs the `Pontos.User.Evaluate` and `Pontos.User.Fetch` to implement the scenario proposed. You can find the structure I created below:

```shell
lib
├── pontos
│   ├── application.ex
│   ├── mailer.ex
│   ├── repo.ex
│   ├── user
│   │   ├── evaluate.ex
│   │   ├── fetch.ex
│   │   ├── insert.ex
│   │   └── server.ex
│   └── user.ex
├── pontos.ex
├── pontos_web
│   ├── controllers
│   │   └── user_controller.ex
│   ├── endpoint.ex
│   ├── gettext.ex
│   ├── router.ex
│   ├── telemetry.ex
│   └── views
│       ├── error_helpers.ex
│       └── error_view.ex
└── pontos_web.ex

5 directories, 17 files
```

I could not find a way to Sandbox on my GenServer/Integration tests so I just left it in a state where it was working

I was also going to dockerize the app but for some reason it was not working the way I expected so I left it out. Maybe cowboy needs a config I'm missing or something.
