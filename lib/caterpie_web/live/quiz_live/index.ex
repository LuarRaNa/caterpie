defmodule CaterpieWeb.QuizLive.Index do
  use CaterpieWeb, :live_view

  alias Caterpie.QMS
  alias Caterpie.QMS.Quiz

  @impl true
  def mount(_params, session, socket) do
    socket = assign_defaults(socket, session)
    {:ok, assign(socket, :quizzes, QMS.list_quizzes(socket.assigns.current_user))}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Quiz")
    |> assign(:quiz, QMS.get_quiz!(socket.assigns.current_user, id))
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

  defp apply_action(socket, :show, %{"id" => id}) do
    socket
    |> assign(:page_title, "Show Quiz")
    |> assign(:quiz, QMS.get_quiz!(socket.assigns.current_user, id))
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    quiz = QMS.get_quiz!(socket.assigns.current_user, id)
    {:ok, _} = QMS.delete_quiz(quiz)

    {:noreply, assign(socket, :quizzes, QMS.list_quizzes(socket.assigns.current_user))}
  end
end
