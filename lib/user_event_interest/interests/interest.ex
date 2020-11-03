defmodule UserEventInterest.Interests.Interest do
  use Ecto.Schema
  import Ecto.Changeset

  schema "interests" do
    field :desc, :string
    field :name, :string

    timestamps()
  end

  @required_attributes [
    :name,
    :desc
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
