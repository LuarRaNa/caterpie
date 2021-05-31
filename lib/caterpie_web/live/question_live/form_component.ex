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

  def handle_event("add-option", _, socket) do
    existing_options =
      Map.get(
        socket.assigns.changeset.changes,
        :options,
        socket.assigns.question_info.options
      )

    options =
      existing_options
      |> Enum.concat([
        QMS.change_option(%QMS.Option{temp_id: get_temp_id()})
      ])

    changeset =
      socket.assigns.changeset
      |> Ecto.Changeset.put_assoc(:options, options)

    {:noreply, assign(socket, changeset: changeset)}
  end

  def handle_event("remove-option", %{"remove" => remove_id}, socket) do
    options =
      socket.assigns.changeset.changes.options
      |> Enum.reject(fn %{data: option} ->
        option.temp_id == remove_id
      end)

    changeset =
      socket.assigns.changeset
      |> Ecto.Changeset.put_assoc(:options, options)

    {:noreply, assign(socket, changeset: changeset)}
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

  # JUST TO GENERATE A RANDOM STRING
  defp get_temp_id, do: :crypto.strong_rand_bytes(5) |> Base.url_encode64() |> binary_part(0, 5)
end
