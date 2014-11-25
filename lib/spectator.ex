defmodule Spectator do
  alias Phoenix.Socket

  def start(endpoint) do
    {:ok, client} = Socket.start_link(self,endpoint)
    Socket.join(client, "rooms", "lobby", %{username: "elixir"})
    listen
  end

  def listen do
    receive do
      msg -> IO.puts "spectator recived message"; IO.inspect msg
    end
    listen
  end
end
