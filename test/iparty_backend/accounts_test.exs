defmodule IpartyBackend.AccountsTest do
  use IpartyBackend.DataCase

  alias IpartyBackend.Accounts

  describe "users" do
    alias IpartyBackend.Accounts.User

    @valid_attrs %{
      email: "herp@space_mail.tld",
      password: "FitkZXnCZwQ3fLEhRNkMHt5tmFg3MLt3",
      username: "herp"
    }
    @update_attrs %{
      email: "herp_new@space.mail.tld",
      password: "MeJKHTcT3muNWPj7mn9wXK9nXb2y5UHW",
      username: "herp_2"
    }
    @invalid_attrs %{email: nil, password: nil, username: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Accounts.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Accounts.get_user!(user.id) == user
    end

    test "get_user/1 returns the user with given id" do
      user = user_fixture()
      assert Accounts.get_user(user.id) == user
    end

    test "get_user/1 returns nil with given invalid user id" do
      assert Accounts.get_user(42) == nil
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Accounts.create_user(@valid_attrs)
      assert user.email == "herp@space_mail.tld"
      assert Bcrypt.verify_pass("FitkZXnCZwQ3fLEhRNkMHt5tmFg3MLt3", user.password_hash)
      assert user.username == "herp"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, %User{} = user} = Accounts.update_user(user, @update_attrs)
      assert user.email == "herp_new@space.mail.tld"
      assert Bcrypt.verify_pass("MeJKHTcT3muNWPj7mn9wXK9nXb2y5UHW", user.password_hash)
      assert user.username == "herp_2"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
      assert user == Accounts.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end
  end
end
