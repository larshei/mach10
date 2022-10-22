defmodule Mach10.UsersTest do
  use Mach10.DataCase

  alias Mach10.Users

  describe "users" do
    alias Mach10.Users.User

    import Mach10.UsersFixtures

    @invalid_attrs %{deleted_at: nil, image_url: nil, last_seen_at: nil, name: nil}

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Users.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Users.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      valid_attrs = %{deleted_at: ~U[2022-10-21 10:20:00Z], image_url: "some image_url", last_seen_at: ~U[2022-10-21 10:20:00Z], name: "some name"}

      assert {:ok, %User{} = user} = Users.create_user(valid_attrs)
      assert user.deleted_at == ~U[2022-10-21 10:20:00Z]
      assert user.image_url == "some image_url"
      assert user.last_seen_at == ~U[2022-10-21 10:20:00Z]
      assert user.name == "some name"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Users.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      update_attrs = %{deleted_at: ~U[2022-10-22 10:20:00Z], image_url: "some updated image_url", last_seen_at: ~U[2022-10-22 10:20:00Z], name: "some updated name"}

      assert {:ok, %User{} = user} = Users.update_user(user, update_attrs)
      assert user.deleted_at == ~U[2022-10-22 10:20:00Z]
      assert user.image_url == "some updated image_url"
      assert user.last_seen_at == ~U[2022-10-22 10:20:00Z]
      assert user.name == "some updated name"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Users.update_user(user, @invalid_attrs)
      assert user == Users.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Users.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Users.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Users.change_user(user)
    end
  end
end
