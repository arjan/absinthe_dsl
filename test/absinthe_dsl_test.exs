defmodule AbsintheDslTest do
  use ExUnit.Case

  defmodule Schema do
    use Absinthe.Schema

    object :user do
      field :id, :id
      field :name, :string
    end

    query do
      field :users, list_of(:user) do
      end
    end
  end


  use AbsintheDSL, AbsintheDslTest.Schema

  test "Generate GraphQL queries" do

    assert (query do
             users do
               name
             end
    end) == "query { users { name } }"

    assert (query do
             users do
               id
             end
    end) == "query { users { id } }"

    assert (query do
             users do
               id
               name
             end
    end) == "query { users { id name } }"

  end

  test "Parameters" do

    assert (query(arg: :string) do
             users(id: arg) do
               name
             end
    end) == "query ($arg: String) { users(id: $arg) { name } }"
  end

end
