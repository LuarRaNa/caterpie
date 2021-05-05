defmodule CaterpieWeb.QuizLive.FormComponent do
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

  @impl true
  def handle_event("validate", %{"quiz" => quiz_params}, socket) do
    changeset =
      socket.assigns.quiz
      |> QMS.change_quiz(quiz_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"quiz" => quiz_params}, socket) do
    save_quiz(socket, socket.assigns.action, quiz_params)
  end

  defp save_quiz(socket, :edit, quiz_params) do
    case QMS.update_quiz(socket.assigns.quiz, quiz_params) do
      {:ok, _quiz} ->
        {:noreply,
         socket
         |> put_flash(:info, "Quiz updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_quiz(socket, :new, quiz_params) do
    case QMS.create_quiz(quiz_params) do
      {:ok, _quiz} ->
        {:noreply,
         socket
         |> put_flash(:info, "Quiz created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
