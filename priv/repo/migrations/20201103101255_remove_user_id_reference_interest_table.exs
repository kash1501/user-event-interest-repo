defmodule UserEventInterest.Repo.Migrations.RemoveUserIdReferenceInterestTable do
  use Ecto.Migration

  def change do
    alter table(:interests) do
      remove :user_id
    end
  end
end
