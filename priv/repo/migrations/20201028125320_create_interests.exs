defmodule UserEventInterest.Repo.Migrations.CreateInterests do
  use Ecto.Migration

  def change do
    create table(:interests) do
      add :name, :string
      add :desc, :string
      add :user_id, references(:users), null: false

      timestamps()
    end

  end
end
