defmodule Caterpie.QMS.QuestionInfo do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "questions_info" do
    field :response_time, :integer
    field :type, :integer
    field :value, :integer
    field :quiz_id, :binary_id

    timestamps()
  end

  @doc false
  def changeset(question_info, attrs) do
    question_info
    |> cast(attrs, [:type, :value, :response_time])
    |> validate_required([:type, :value, :response_time])
  end
end
