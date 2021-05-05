defmodule Caterpie.QMS.Quiz do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "quizzes" do
    field :description, :string
    field :name, :string
    field :user_id, :binary_id

    timestamps()
  end

  @doc false
  def changeset(quiz, attrs) do
    quiz
    |> cast(attrs, [:name, :description])
    |> validate_required([:name, :description])
  end
end
