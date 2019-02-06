# Tasks

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

The API endpoint uses these URLs:

- `GET /api/tasks` to retrieve all of the tasks.
- `GET /api/tasks?priority=1` to retrieve all of the tasks based on priority (1-3).
- `POST /api/tasks` to send a priority with a payload like this:

```json
{"task":{"content": "API task", "priority": 2}}
```

The `POST` request for API requires validation. It could be in two different ways:

1. Use `Authorization: Bearer token-1234` or other token added in `Tasks.Auth` server.
2. Register your user vía the new endpoint `POST /api/register` using the following payload:

```json
{"user": "manuel", "pass": "1234"}
```

You'll get then a JWT token and then use it as `Authorization: Bearer <token>`.
