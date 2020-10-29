defmodule UserEventInterest.Events.Event do
  use Ecto.Schema
  import Ecto.Changeset

  schema "events" do
    field :date, :date
    field :description, :string
    field :duration, :time
    field :host, :string
    field :location, :string
    field :type, :string

    timestamps()
  end

  @required_attributes [
    :date,
    :host,
    :type,
    :location,
    :user_id

  ]

  @optional_attributes [
    :description,
    :duration
  ]

  @doc false
  def changeset(event, attrs) do
    event
    |> cast(attrs, @required_attributes ++ @optional_attributes)
    |> validate_required(@required_attributes)
  end
end
