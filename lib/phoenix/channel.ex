defmodule Phoenix.Channel do
  alias Phoenix.Socket

  defmacro __using__(options)  do
    quote do
      import Phoenix.Channel
      # import Phoenix.Socket [only: send]
    end
  end

  def connect(url, channel, topic) do
    IO.puts "connecting... #{endpoint}"
    {:ok, socket} = Socket.start_link(pid,endpoint)
    %{socket: socket, channel: channel, topic: topic}
  end
end
