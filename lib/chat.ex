defmodule Chat do
  use Behaviour

  def start(_type \\ [], _args \\ []) do
    Chat.Window.start
    #Chat.Supervisor.start_link
  end

end
