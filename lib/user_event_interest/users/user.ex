defmodule UserEventInterest.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :age, :integer
    field :email, :string
    field :full_name, :string
    field :is_admin, :boolean, default: false
    field :password, :string
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
    |> validate_format(:email, ~r/^[A-Za-z0-9._%+-+']+@[A-Za-z0-9.-]+\.[A-Za-z]+$/)
    |> validate_length(:password, min: 8)
  end
end
