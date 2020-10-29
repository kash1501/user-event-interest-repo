defmodule UserEventInterest.Repo.Migrations.CreateTableUserEvent do
  use Ecto.Migration

  def change do
    create table(:user_events) do
      add :user_id, references(:users), null: false
      add :event_id, references(:events), null: false
      add :is_attending, :boolean, default: true, null: false
      add :is_cancelling, :boolean, default: false, null: false

      timestamps()
    end

  end
end
