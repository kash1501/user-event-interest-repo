defmodule UserEventInterest.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :age, :integer
    field :email, :string
    field :full_name, :string
    field :is_admin, :boolean, default: false
    field :password, :string
    has_many :interest, UserEventInterest.Interests.Interest

    timestamps()
  end

  @required_attributes [
    :email,
    :password,
    :is_admin
  ]

  @optional_attributes [
    :full_name,
    :age
  ]

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, @required_attributes ++ @optional_attributes)
    |> validate_required(@required_attributes)
  end
end
