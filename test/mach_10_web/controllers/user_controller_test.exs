defmodule Mach10Web.UserControllerTest do
  use Mach10Web.ConnCase

  import Mach10.UsersFixtures

  alias Mach10.Users.User

  @create_attrs %{
    deleted_at: ~U[2022-10-21 10:20:00Z],
    image_url: "some image_url",
    last_seen_at: ~U[2022-10-21 10:20:00Z],
    name: "some name"
  }
  @update_attrs %{
    deleted_at: ~U[2022-10-22 10:20:00Z],
    image_url: "some updated image_url",
    last_seen_at: ~U[2022-10-22 10:20:00Z],
    name: "some updated name"
  }
  @invalid_attrs %{deleted_at: nil, image_url: nil, last_seen_at: nil, name: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all users", %{conn: conn} do
      conn = get(conn, Routes.user_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create user" do
    test "renders user when data is valid", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :create), user: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.user_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "deleted_at" => "2022-10-21T10:20:00Z",
               "image_url" => "some image_url",
               "last_seen_at" => "2022-10-21T10:20:00Z",
               "name" => "some name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :create), user: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update user" do
    setup [:create_user]

    test "renders user when data is valid", %{conn: conn, user: %User{id: id} = user} do
      conn = put(conn, Routes.user_path(conn, :update, user), user: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.user_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "deleted_at" => "2022-10-22T10:20:00Z",
               "image_url" => "some updated image_url",
               "last_seen_at" => "2022-10-22T10:20:00Z",
               "name" => "some updated name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, user: user} do
      conn = put(conn, Routes.user_path(conn, :update, user), user: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete user" do
    setup [:create_user]

    test "deletes chosen user", %{conn: conn, user: user} do
      conn = delete(conn, Routes.user_path(conn, :delete, user))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.user_path(conn, :show, user))
      end
    end
  end

  defp create_user(_) do
    user = user_fixture()
    %{user: user}
  end
end
