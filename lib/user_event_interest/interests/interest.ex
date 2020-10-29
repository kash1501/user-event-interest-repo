defmodule UserEventInterest.Interests.Interest do
  use Ecto.Schema
  import Ecto.Changeset

  schema "interests" do
    field :desc, :string
    field :name, :string
    belongs_to :user, UserEventInterest.Users.User

    timestamps()
  end

  @required_attributes [
    :name,
    :desc,
    :user_id
  ]

  @optional_attributes [
  ]

  @doc false
  def changeset(interest, attrs) do
    interest
    |> cast(attrs, @required_attributes ++ @optional_attributes)
    |> validate_required(@required_attributes)
  end
end
