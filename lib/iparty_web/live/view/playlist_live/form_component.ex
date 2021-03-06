defmodule IpartyWeb.PlaylistLive.FormComponent do
  use IpartyWeb, :live_component

  alias Iparty.Accounts

  @impl true
  def update(%{playlist: playlist} = assigns, socket) do
    changeset = Accounts.change_playlist(playlist)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"playlist" => playlist_params}, socket) do
    changeset =
      socket.assigns.playlist
      |> Accounts.change_playlist(playlist_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"playlist" => playlist_params}, socket) do
    save_playlist(socket, socket.assigns.action, playlist_params)
  end

  defp save_playlist(socket, :edit, playlist_params) do
    case Accounts.update_playlist(socket.assigns.playlist, playlist_params) do
      {:ok, _playlist} ->
        {:noreply,
         socket
         |> put_flash(:info, "Playlist updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_playlist(socket, :new, playlist_params) do
    case Accounts.create_playlist(playlist_params) do
      {:ok, _playlist} ->
        {:noreply,
         socket
         |> put_flash(:info, "Playlist created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
