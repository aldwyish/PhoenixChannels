defmodule ChatChannel do
  use Phoenix.Channel, channel: "rooms", topic: "lobby"

  def event("user:entered", msg) do
    Spectator.new_user(msg)
   end

  def event("new:msg", msg) do
    Spectator.new_message(msg)
  end

  def event(event, msg) do
    IO.inspect msg
  end

end
