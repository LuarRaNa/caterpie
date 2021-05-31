defmodule CaterpieWeb.QuizLive.ShowComponent do
  use CaterpieWeb, :live_component

  alias Caterpie.QMS

  @impl true
  def update(%{quiz: quiz} = assigns, socket) do
    changeset = QMS.change_quiz(quiz)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end
end
