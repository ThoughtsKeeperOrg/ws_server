defmodule WsServerWeb.RoomChannel do
  use Phoenix.Channel

  # intercept ["new_msg", "user_joined"]

  def join("room:lobby", _message, socket) do
    {:ok, socket}
  end

  # # def handle_in("new_msg", %{"body" => body}, socket) do
  # def handle_in("new_msg", _obj, socket) do
  #   # broadcast!(socket, "new_msg", %{body: 'body'})

  #   IO.puts("----------------")
  #   # IO.inspect(body)
  #   IO.puts("----------------")
    
  #   {:noreply, socket}
  # end

  # def handle_out("new_msg", _obj, socket) do
  #   # broadcast!(socket, "new_msg", %{body: 'body'})

  #   IO.puts("oooooooooooooooooooooo")
  #   # IO.inspect(body)
  #   IO.puts("oooooooooooooooooooooo")
    
  #   {:noreply, socket}
  # end

  # def join("room:" <> _user_token, socket) do
  #   {:ok, socket}
  # end
  # def join("room:" <> _private_room_id, _params, _socket) do
  #   {:error, %{reason: "unauthorized"}}
  # end
end

# https://hexdocs.pm/phoenix/channels.html

