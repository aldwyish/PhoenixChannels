defmodule Phoenix.Channel do
  alias Phoenix.Socket

  defmacro __using__(opts)  do
    IO.inspect opts
    quote do
      @channel unquote(opts[:channel])
      @topic   unquote(opts[:topic])

      def topic, do: @topic
      def channel, do: @channel

      import Phoenix.Channel
      # import Phoenix.Socket [only: send]
    end
  end
  # defmacro event(name,callback) do
  #   def event(unquote(name)) do
  #     callback()
  #   end
  # end

end
