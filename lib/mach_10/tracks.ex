defmodule Mach10.Tracks do
  @moduledoc """
  The Tracks context.
  """

  import Ecto.Query, warn: false
  alias Mach10.Repo

  alias Mach10.Tracks.Track

  @doc """
  Returns the list of tracks.

  ## Examples

      iex> list_tracks()
      [%Track{}, ...]

  """
  def list_tracks do
    Repo.all(Track)
  end

  @doc """
  Gets a single track.

  Raises `Ecto.NoResultsError` if the Track does not exist.

  ## Examples

      iex> get_track!(123)
      %Track{}

      iex> get_track!(456)
      ** (Ecto.NoResultsError)

  """
  def get_track(id), do: Repo.get(Track, id)
  def get_track!(id), do: Repo.get!(Track, id)
  def get_track_by_reference(reference), do: Repo.get_by(Track, reference: reference)
  def get_track_by_reference!(reference), do: Repo.get_by!(Track, reference: reference)

  def search(term) do
    ilike_term = "%#{term}%"

    query = from t in Track,
      where: ilike(t.reference, ^ilike_term) or ilike(t.name, ^ilike_term)

    Repo.all(query)
  end

  @doc """
  Creates a track.

  ## Examples

      iex> create_track(%{field: value})
      {:ok, %Track{}}

      iex> create_track(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_track(attrs \\ %{}) do
    {ok, track} = result = %Track{}
    |> Track.changeset(attrs)
    |> Repo.insert()

    if ok == :ok do
      Phoenix.PubSub.broadcast(Mach10.PubSub, "tracks", {:track, :inserted, track})
    end

    result
  end

  @doc """
  Updates a track.

  ## Examples

      iex> update_track(track, %{field: new_value})
      {:ok, %Track{}}

      iex> update_track(track, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_track(%Track{} = track, attrs) do
    {ok, track} = result = track
    |> Track.changeset(attrs)
    |> Repo.update()

    if ok == :ok do
      Phoenix.PubSub.broadcast(Mach10.PubSub, "tracks", {:track, :updated, track})
    end

    result
  end

  @doc """
  Deletes a track.

  ## Examples

      iex> delete_track(track)
      {:ok, %Track{}}

      iex> delete_track(track)
      {:error, %Ecto.Changeset{}}

  """
  def delete_track(%Track{} = track) do
    {ok, track} = result = Repo.delete(track)

    if ok == :ok do
      Phoenix.PubSub.broadcast(Mach10.PubSub, "tracks", {:track, :deleted, track})
    end

    result
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking track changes.

  ## Examples

      iex> change_track(track)
      %Ecto.Changeset{data: %Track{}}

  """
  def change_track(%Track{} = track, attrs \\ %{}) do
    Track.changeset(track, attrs)
  end
end
