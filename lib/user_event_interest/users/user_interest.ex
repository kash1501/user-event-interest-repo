defmodule UserEventInterest.Users.UserInterest do
  use Ecto.Schema
  import Ecto.Changeset

  schema "user_interests" do
    belongs_to :user, UserEventInterest.Users.User
    belongs_to :interest, UserEventInterest.Interests.Interest
    field :is_adding, :boolean, default: true

    timestamps()
  end

  @required_attributes [
    :user_id,
    :interest_id
  ]

  @optional_attributes [
    :is_adding
  ]

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, @required_attributes ++ @optional_attributes)
    |> validate_required(@required_attributes)
  end
end
