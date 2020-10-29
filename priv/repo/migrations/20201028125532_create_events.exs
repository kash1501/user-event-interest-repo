defmodule UserEventInterest.Repo.Migrations.CreateEvents do
  use Ecto.Migration

  def change do
    create table(:events) do
      add :description, :string
      add :type, :string
      add :date, :date
      add :duration, :time
      add :host, :string
      add :location, :string

      timestamps()
    end

  end
end
