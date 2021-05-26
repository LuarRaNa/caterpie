defmodule CaterpieWeb.QuestionLive.IndexComponent do
  use CaterpieWeb, :live_component

  alias Caterpie.QMS

  @impl true
  def update(%{quiz: quiz} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign(:questions, QMS.list_questions_info(quiz))}
  end
end
