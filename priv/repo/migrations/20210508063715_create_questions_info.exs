defmodule Caterpie.Repo.Migrations.CreateQuestionsInfo do
  use Ecto.Migration

  def change do
    create table(:questions_info, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :type, :integer
      add :value, :integer
      add :response_time, :integer
      add :quiz_id, references(:quizzes, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:questions_info, [:quiz_id])
  end
end
