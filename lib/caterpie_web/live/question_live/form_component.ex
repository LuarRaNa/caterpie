defmodule CaterpieWeb.QuestionLive.FormComponent do
  use CaterpieWeb, :live_component

  alias Caterpie.QMS

  @impl true
  def update(%{question_info: question_info} = assigns, socket) do
    changeset = QMS.change_question_info(question_info)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"question_info" => question_info_params}, socket) do
    changeset =
      socket.assigns.question_info
      |> QMS.change_question_info(question_info_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"question_info" => question_info_params}, socket) do
    save_question_info(socket, socket.assigns.action, question_info_params)
  end

  defp save_question_info(socket, :edit_question, question_info_params) do
    case QMS.update_question_info(socket.assigns.question_info, question_info_params) do
      {:ok, _question_info} ->
        {:noreply,
         socket
         |> put_flash(:info, "Quiz updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_question_info(socket, :new_question, question_info_params) do
    case QMS.create_question_info(socket.assigns.quiz, question_info_params) do
      {:ok, _question_info} ->
        {:noreply,
         socket
         |> put_flash(:info, "Question created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
