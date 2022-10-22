defmodule Mach10Web.TrackControllerTest do
  use Mach10Web.ConnCase

  import Mach10.TracksFixtures

  alias Mach10.Tracks.Track

  @create_attrs %{
    deleted_at: ~U[2022-10-21 10:20:00Z],
    image_url: "some image_url",
    name: "some name"
  }
  @update_attrs %{
    deleted_at: ~U[2022-10-22 10:20:00Z],
    image_url: "some updated image_url",
    name: "some updated name"
  }
  @invalid_attrs %{deleted_at: nil, image_url: nil, name: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all tracks", %{conn: conn} do
      conn = get(conn, Routes.track_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create track" do
    test "renders track when data is valid", %{conn: conn} do
      conn = post(conn, Routes.track_path(conn, :create), track: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.track_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "deleted_at" => "2022-10-21T10:20:00Z",
               "image_url" => "some image_url",
               "name" => "some name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.track_path(conn, :create), track: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update track" do
    setup [:create_track]

    test "renders track when data is valid", %{conn: conn, track: %Track{id: id} = track} do
      conn = put(conn, Routes.track_path(conn, :update, track), track: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.track_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "deleted_at" => "2022-10-22T10:20:00Z",
               "image_url" => "some updated image_url",
               "name" => "some updated name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, track: track} do
      conn = put(conn, Routes.track_path(conn, :update, track), track: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete track" do
    setup [:create_track]

    test "deletes chosen track", %{conn: conn, track: track} do
      conn = delete(conn, Routes.track_path(conn, :delete, track))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.track_path(conn, :show, track))
      end
    end
  end

  defp create_track(_) do
    track = track_fixture()
    %{track: track}
  end
end
