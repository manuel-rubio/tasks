defmodule Tasks.Auth do
  use GenServer

  def start_link(initial_tokens \\ []) do
    GenServer.start_link __MODULE__, [initial_tokens], name: __MODULE__
  end

  def add(token), do: GenServer.cast __MODULE__, {:add, token}
  def check(token), do: GenServer.call __MODULE__, {:check, token}

  @impl true
  def init(initial_tokens) when is_list(initial_tokens) do
    {:ok, initial_tokens}
  end

  @impl true
  def handle_cast({:add, token}, tokens) do
    {:noreply, [token|tokens]}
  end

  @impl true
  def handle_call({:check, token}, _from, tokens) do
    {:reply, token in tokens, tokens}
  end
end
