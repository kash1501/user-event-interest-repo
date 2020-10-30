defmodule UserEventInterest.Repo.Migrations.RectifyUserTableIssue do
  use Ecto.Migration

  def change do
    alter table(:users) do
      remove :password
      add :password, :string
    end
    create unique_index(:users, [:email])
  end
end
