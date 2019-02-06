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
