defmodule CaterpieWeb.QuizLive.Index do
  use CaterpieWeb, :live_view

  alias Caterpie.QMS
  alias Caterpie.QMS.Quiz

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :quizzes, list_quizzes())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Quiz")
    |> assign(:quiz, QMS.get_quiz!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Quiz")
    |> assign(:quiz, %Quiz{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Quizzes")
    |> assign(:quiz, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    quiz = QMS.get_quiz!(id)
    {:ok, _} = QMS.delete_quiz(quiz)

    {:noreply, assign(socket, :quizzes, list_quizzes())}
  end

  defp list_quizzes do
    QMS.list_quizzes()
  end
end
