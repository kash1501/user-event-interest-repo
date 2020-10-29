defmodule UserEventInterest.InterestsTest do
  use UserEventInterest.DataCase

  alias UserEventInterest.Interests

  describe "interests" do
    alias UserEventInterest.Interests.Interest

    @valid_attrs %{desc: "some desc", name: "some name"}
    @update_attrs %{desc: "some updated desc", name: "some updated name"}
    @invalid_attrs %{desc: nil, name: nil}

    def interest_fixture(attrs \\ %{}) do
      {:ok, interest} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Interests.create_interest()

      interest
    end

    test "list_interests/0 returns all interests" do
      interest = interest_fixture()
      assert Interests.list_interests() == [interest]
    end

    test "get_interest!/1 returns the interest with given id" do
      interest = interest_fixture()
      assert Interests.get_interest!(interest.id) == interest
    end

    test "create_interest/1 with valid data creates a interest" do
      assert {:ok, %Interest{} = interest} = Interests.create_interest(@valid_attrs)
      assert interest.desc == "some desc"
      assert interest.name == "some name"
    end

    test "create_interest/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Interests.create_interest(@invalid_attrs)
    end

    test "update_interest/2 with valid data updates the interest" do
      interest = interest_fixture()
      assert {:ok, %Interest{} = interest} = Interests.update_interest(interest, @update_attrs)
      assert interest.desc == "some updated desc"
      assert interest.name == "some updated name"
    end

    test "update_interest/2 with invalid data returns error changeset" do
      interest = interest_fixture()
      assert {:error, %Ecto.Changeset{}} = Interests.update_interest(interest, @invalid_attrs)
      assert interest == Interests.get_interest!(interest.id)
    end

    test "delete_interest/1 deletes the interest" do
      interest = interest_fixture()
      assert {:ok, %Interest{}} = Interests.delete_interest(interest)
      assert_raise Ecto.NoResultsError, fn -> Interests.get_interest!(interest.id) end
    end

    test "change_interest/1 returns a interest changeset" do
      interest = interest_fixture()
      assert %Ecto.Changeset{} = Interests.change_interest(interest)
    end
  end
end
