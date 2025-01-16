defmodule WsServerWeb.RoomChannel do
  use Phoenix.Channel

  def join("room:lobby", _message, socket) do
    {:ok, socket}
  end

  # def join("room:" <> _user_token, socket) do
  #   {:ok, socket}
  # end

  # def join("room:" <> _private_room_id, _params, _socket) do
  #   {:error, %{reason: "unauthorized"}}
  # end
end

# https://hexdocs.pm/phoenix/channels.html

