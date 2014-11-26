defmodule Spectator do
  alias Phoenix.Socket

  def start(url \\ "ws://localhost:4000/ws") do
    {:ok, socket} = Socket.start_link(url)
    Socket.join(socket, "rooms", "lobby", %{username: "elixir"})
    Socket.register(socket, ChatChannel.channel, ChatChannel)
  end

  def new_user(msg), do: IO.inspect msg
  def new_message(msg), do: IO.inspect msg
end
