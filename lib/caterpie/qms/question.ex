defmodule Caterpie.QMS.Question do
  use Ecto.Schema
  import Ecto.Changeset

  alias Caterpie.QMS.QuestionInfo

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "questions" do
    field :is_active, :boolean, default: true
    field :text, :string
    belongs_to :question_info, QuestionInfo

    timestamps()
  end

  @doc false
  def changeset(question, attrs) do
    question
    |> cast(attrs, [:text, :is_active])
    |> validate_required([:text])
  end
end
