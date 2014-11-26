defmodule Phoenix.Socket do
  alias Poison, as: JSON

  @doc """
  Starts the WebSocket server for given ws URL. Received Socket.Message's
  are forwarded to the channels pid
  """
  def start_link(url) do
    :crypto.start
    :ssl.start
    :websocket_client.start_link(String.to_char_list(url), __MODULE__, %{})
  end

  def init(%{}, _conn_state) do
    {:ok, %{}}
  end

  def register(socket, channel, module) do
    send socket,{:channel, channel, module}
  end

  def on_message(%{channel: channel, event: event, message: msg}, channels) do
    trigger(channels[channel], event, msg)
  end

  def trigger(channel, event, msg) do
    apply(channel,:event,[event,msg])
  end

  @doc """
  Receives JSON encoded Socket.Message from remote WS endpoint and
  forwards message to client channels process
  """
  def websocket_handle({:text, msg}, _conn_state, channels) do
    IO.puts "handle"
    msg = Phoenix.Socket.Message.parse!(msg)
    on_message(msg,channels)
    {:ok, channels}
  end


  @doc """
  Sends JSON encoded Socket.Message to remote WS endpoint
  """
  def websocket_info({:send, msg}, _conn_state, channels) do
    IO.puts "info"
    {:reply, {:text, msg}, channels}
  end

  def websocket_info({:channel, channel, module}, _conn_state, channels) do
    {:ok, Dict.put(channels, channel, module)}
  end

  def websocket_terminate(_reason, _conn_state, _state) do
    :ok
  end

  @doc """
  Sends an event to the WebSocket server per the Message protocol
  """
  def send_event(server_pid, channel, topic, event, msg) do
    msg = json!(%{channel: channel, topic: topic, event: event, message: msg})
    send server_pid, {:send, msg}
  end

  @doc """
  Sends join event to the WebSocket server per the Message protocol
  """
  def join(server_pid, channel, topic, msg) do
    send_event(server_pid, channel, topic, "join", msg)
  end

  @doc """
  Sends leave event to the WebSocket server per the Message protocol
  """
  def leave(server_pid, channel, topic, msg) do
    send_event(server_pid, channel, topic, "leave", msg)
  end

  defp json!(map), do: JSON.encode!(map)
end
