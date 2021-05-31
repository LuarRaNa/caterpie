defmodule Caterpie.QMS.Option do
  use Ecto.Schema
  import Ecto.Changeset

  alias Caterpie.QMS.QuestionInfo

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "options" do
    field :is_correct, :boolean, default: false
    field :text, :string
    belongs_to :question_info, QuestionInfo
    field :temp_id, :string, virtual: true
    field :delete, :boolean, virtual: true

    timestamps()
  end

  @doc false
  def changeset(option, attrs) do
    option
    |> Map.put(:temp_id, option.temp_id || attrs["temp_id"])
    |> cast(attrs, [:text, :is_correct, :delete])
    |> validate_required([:text, :is_correct])
    |> maybe_mark_for_deletion()
  end

  defp maybe_mark_for_deletion(%{data: %{id: nil}} = changeset), do: changeset

  defp maybe_mark_for_deletion(changeset) do
    if get_change(changeset, :delete) do
      %{changeset | action: :delete}
    else
      changeset
    end
  end
end
