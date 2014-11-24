defmodule Spectator do
  alias Phoenix.WebsocketClient
  def start(endpoint) do
    {:ok, client} = Phoenix.WebsocketClient.start_link(self,endpoint)
    WebsocketClient.join(client, "rooms", "lobby", %{username: "elixir"})
    listen
  end

  def listen do
    receive do
      msg -> IO.puts "spectator recived message"; IO.inspect msg
    end
    listen
  end
end
