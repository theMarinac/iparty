defmodule IpartyWeb.Live.Component.BoilerRoom.PlaylistItem do
  use IpartyWeb, :live_component

  def render(assigns) do
    ~L"""
    <div class="playitem flex-shrink-0 flex flex-col justify-between shadow rounded-lg bg-gray-100 dark:bg-erie-black-500 w-64 h-48 mr-4 pt-2">
      <div class="flex justify-center items-center">
        <%= img_tag(@playitem.info.thumbnails["medium"]["url"], class: "w-40") %>
      </div>
      <div class="break-words">
        <%= String.slice(@playitem.info.title, 0..58) %>
      </div>
      <!-- Control start duration -->
      <div class="flex flex-row justify-start items-center bg-gray-300 text-gray-700 dark:bg-erie-black-600 dark:text-sage-500 py-1">
        <div class="mr-1 flex flex-row justify-center items-center h-10">
          <span class="text-sm mx-1">Start from</span>
          <input type="number" pattern="[0-9]*" min="0" max="<%= @playitem.info.duration %>" id="<%= @playitem.uuid %>" class="appearance-none bg-white shadow rounded-lg px-1 pl-3 dark:bg-erie-black-700 focus:outline-none">
        </div>
        <div class="flex">
          <button data-tooltip="Play" onclick="PlayVideoIdTimestamp('<%= @playitem.info.id %>', '<%= @playitem.uuid %>')"
            class="flex justify-center items-center text-lg bg-blue-500 text-gray-900 cursor-pointer w-6 h-6 rounded-full opacity-75 ml-2 hover:opacity-100 focus:outline-none">
            <i class="fad fa-play-circle"></i>
          </button>
          <button data-tooltip="Remove" value="<%= @playitem.uuid %>" phx-target="<%= @myself %>" phx-click="remove-from-playlist"
            class="flex justify-center items-center text-lg bg-red-300 text-red-900 cursor-pointer w-6 h-6 rounded-full opacity-75 ml-2 hover:opacity-100 focus:outline-none">
            <i class="fad fa-times-circle"></i>
          </button>
        </div>
      </div>
    </div>
    """
  end
end
