defmodule Caterpie.QMS.QuestionInfo do
  use Ecto.Schema
  import Ecto.Changeset

  alias Caterpie.QMS.Quiz
  alias Caterpie.QMS.Question

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "questions_info" do
    field :response_time, :integer
    field :type, :integer
    field :value, :integer
    belongs_to :quiz, Quiz
    has_many :questions, Question

    timestamps()
  end

  @doc false
  def changeset(question_info, attrs) do
    question_info
    |> cast(attrs, [:type, :value, :response_time])
    |> validate_required([:type, :value, :response_time])
  end
end
