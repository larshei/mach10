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
  def get_record!(id), do: Repo.get!(Record, id)

  @doc """
  Creates a record.

  ## Examples

      iex> create_record(%{field: value})
      {:ok, %Record{}}

      iex> create_record(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_record(attrs \\ %{}) do
    %Record{}
    |> Record.changeset(attrs)
    |> Repo.insert()
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
    record
    |> Record.changeset(attrs)
    |> Repo.update()
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
    Repo.delete(record)
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
