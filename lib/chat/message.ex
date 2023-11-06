defmodule Chat.Message do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

  schema "messages" do
    field :message, :string
    field :name, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(message, attrs) do
    message
    |> cast(attrs, [:name, :message])
    |> validate_required([:name, :message])
  end

  @doc """
  This function accepts a single parameter limit to only return a fixed/maximum number of records.
  It uses Ecto's all function to fetch all records from the database.
  Message is the name of the schema/table we want to get records for, and
  limit is the maximum number of records to fetch.
  """
  def get_messages(limit \\ 20) do
    Chat.Message
    |> limit(^limit)
    |> order_by(desc: :inserted_at)
    |> Chat.Repo.all()
  end
end
