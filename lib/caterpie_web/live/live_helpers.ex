defmodule CaterpieWeb.LiveHelpers do
  import Phoenix.LiveView.Helpers

  @doc """
  Renders a component inside the `CaterpieWeb.ModalComponent` component.

  The rendered modal receives a `:return_to` option to properly update
  the URL when the modal is closed.

  ## Examples

      <%= live_modal @socket, CaterpieWeb.QuizLive.FormComponent,
        id: @quiz.id || :new,
        action: @live_action,
        quiz: @quiz,
        return_to: Routes.quiz_index_path(@socket, :index) %>
  """
  def live_modal(socket, component, opts) do
    path = Keyword.fetch!(opts, :return_to)
    modal_opts = [id: :modal, return_to: path, component: component, opts: opts]
    live_component(socket, CaterpieWeb.ModalComponent, modal_opts)
  end

  def assign_defaults(socket, %{"user_token" => user_token} = _session) do
    socket =
      socket
      |> Phoenix.LiveView.assign_new(:current_user, fn ->
        Caterpie.Accounts.get_user_by_session_token(user_token)
      end)

    if socket.assigns.current_user do
      socket
    else
      Phoenix.LiveView.redirect(socket, to: "/login")
    end
  end
end
