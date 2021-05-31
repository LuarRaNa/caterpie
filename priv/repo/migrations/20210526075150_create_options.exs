defmodule Caterpie.Repo.Migrations.CreateOptions do
  use Ecto.Migration

  def change do
    create table(:options, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :text, :text
      add :is_correct, :boolean, default: false, null: false
      add :question_info_id, references(:questions_info, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:options, [:question_info_id])
  end
end
