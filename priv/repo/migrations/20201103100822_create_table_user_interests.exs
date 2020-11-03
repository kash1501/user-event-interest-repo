defmodule UserEventInterest.Repo.Migrations.CreateTableUserInterests do
  use Ecto.Migration

  def change do
    create table(:user_interests) do
      add :user_id, references(:users), null: false
      add :interest_id, references(:interests), null: false
      add :is_adding, :boolean, default: true, null: false

      timestamps()
    end

  end
end
