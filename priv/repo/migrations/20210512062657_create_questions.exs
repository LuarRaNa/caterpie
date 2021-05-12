defmodule Caterpie.Repo.Migrations.CreateQuestions do
  use Ecto.Migration

  def change do
    create table(:questions, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :text, :text
      add :is_active, :boolean, default: false, null: false
      add :question_info_id, references(:questions_info, on_delete: :nothing, type: :binary_id), null: false

      timestamps()
    end

    create index(:questions, [:question_info_id])
  end
end
