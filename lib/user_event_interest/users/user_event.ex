defmodule UserEventInterest.Users.UserEvent do
  use Ecto.Schema
  import Ecto.Changeset

  schema "user_events" do
    belongs_to :user, UserEventInterest.Users.User
    belongs_to :event, UserEventInterest.Events.Event
    field :is_attending, :boolean, default: true
    field :is_cancelling, :boolean, default: false

    timestamps()
  end

  @required_attributes [
    :user_id,
    :event_id
  ]

  @optional_attributes [

  ]

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, @required_attributes ++ @optional_attributes)
    |> validate_required(@required_attributes)
  end
end
