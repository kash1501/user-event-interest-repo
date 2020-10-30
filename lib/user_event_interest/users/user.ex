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
    has_many :events, UserEventInterest.Events.Event


    timestamps()
  end

  @required_attributes [
    :email,
    :password,
    :is_admin,
    :full_name,
    :age
  ]

  @optional_attributes [

  ]

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, @required_attributes ++ @optional_attributes)
    |> validate_required(@required_attributes)
    |> unique_constraint(:email)
    |> validate_format(:email, ~r/@/)
    |> validate_length(:password, min: 8)
  end
end
