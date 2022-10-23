defmodule Mach10.Records do
  @moduledoc """
  The Records context.
  """

  import Ecto.Query, warn: false
  alias Mach10.Repo

  alias Mach10.Records.Record
  alias Mach10.Tracks.Track
  alias Mach10.Users.User

  @doc """
  Returns the list of records.

  ## Examples

      iex> list_records()
      [%Record{}, ...]

  """
  def list_records do
    Repo.all(Record)
  end

  @doc """
  Gets a single record.

  Raises `Ecto.NoResultsError` if the Record does not exist.

  ## Examples

      iex> get_record!(123)
      %Record{}

      iex> get_record!(456)
      ** (Ecto.NoResultsError)

  """
  def get_record(track_id, user_id) do
    Repo.get_by(Record, [track_id: track_id, user_id: user_id])
    |> case do
      nil -> nil
      record -> Repo.preload(record, [:user, :track])
    end
  end

  @doc """
  Creates a record.

  ## Examples

      iex> create_record(%{field: value})
      {:ok, %Record{}}

      iex> create_record(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_record(attrs \\ %{}) do
    {ok, record} = result = %Record{}
    |> Record.changeset(attrs)
    |> Repo.insert(on_conflict: {:replace, [:updated_at, :time_ms]}, conflict_target: [:track_id, :user_id], returning: true)

    if ok == :ok do
      record = record |> Repo.preload([:user, :track])
      Phoenix.PubSub.broadcast(Mach10.PubSub, "record:track:#{record.track_id}", {:record, :inserted, record})
      Phoenix.PubSub.broadcast(Mach10.PubSub, "record:user:#{record.user_id}", {:record, :inserted, record})
    end

    result
  end

  @doc """
  Updates a record.

  ## Examples

      iex> update_record(record, %{field: new_value})
      {:ok, %Record{}}

      iex> update_record(record, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_record(%Record{} = record, attrs) do
    {ok, record} = result = record
    |> Record.changeset(attrs)
    |> Repo.update()

    if ok == :ok do
      record = record |> Repo.preload([:user, :track])
      Phoenix.PubSub.broadcast(Mach10.PubSub, "record:track:#{record.track_id}", {:record, :updated, record})
      Phoenix.PubSub.broadcast(Mach10.PubSub, "record:user:#{record.user_id}", {:record, :updated, record})
    end

    result
  end

  @doc """
  Deletes a record.

  ## Examples

      iex> delete_record(record)
      {:ok, %Record{}}

      iex> delete_record(record)
      {:error, %Ecto.Changeset{}}

  """
  def delete_record(%Record{} = record) do
    {ok, record} = result = Repo.delete(record)

    if ok == :ok do
      Phoenix.PubSub.broadcast(Mach10.PubSub, "record:track:#{record.track_id}", {:record, :deleted, record})
      Phoenix.PubSub.broadcast(Mach10.PubSub, "record:user:#{record.user_id}", {:record, :deleted, record})
    end

    result
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking record changes.

  ## Examples

      iex> change_record(record)
      %Ecto.Changeset{data: %Record{}}

  """
  def change_record(%Record{} = record, attrs \\ %{}) do
    Record.changeset(record, attrs)
  end

  def by_user(user_id) do
    records = from r in Record,
      where: [user_id: ^user_id],
      join: t in assoc(r, :track),
      order_by: [asc: :time_ms],
      preload: [track: t]

    Repo.all(records)
  end

  def by_track(track_id) do
    records = from r in Record,
      where: [track_id: ^track_id],
      join: u in assoc(r, :user),
      order_by: [asc: :time_ms],
      preload: [user: u]

    Repo.all(records)
  end

  def top_100_for_track(track_id) do
    records = from r in Record,
    where: [track_id: ^track_id],
    join: u in assoc(r, :user),
    order_by: [asc: :time_ms],
    limit: 100,
    preload: [user: u]

  Repo.all(records)
  end
end
