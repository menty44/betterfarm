defmodule Betterfarm.Product.Account do
  @moduledoc """
   This is product context
  """
  import Ecto.Query
  alias Betterfarm.Category
  alias Betterfarm.Repo
  alias Betterfarm.Product
  alias Betterfarm.ProductName

  @doc """
  Fetches product_name from database otherwise it will insert the product_name if it doesn't exist.
  Returns %ProductName{}
  """
  @spec create_or_get_product_name(String.t()) :: %ProductName{}
  def create_or_get_product_name(name) do
    Repo.get_by(ProductName, name: name) || Repo.insert!(%ProductName{name: name})
  end

  @doc """
  Fetches category name from database otherwise it will insert the category name if it doesn't exist.
  Returns %Category{}
  """

  @spec create_or_get_category(String.t()) :: %Category{}
  def create_or_get_category(name) do
    Repo.get_by(Category, name: name) || Repo.insert!(%Category{name: name})
  end

  @doc """
  Returns a changeset
  """
  @spec change_product(struct()) :: %Ecto.Changeset{}
  def change_product(%Product{} = product) do
    product
    |> Product.changeset()
  end

  @doc """
  Returns a list of product_name
  """
  def list_product_name do
    query = from p in ProductName, select: {p.name, p.id}

    query
    |> Repo.all()
  end

  @doc """
  Returns list of categories
  """

  def list_category_name do
    query = from c in Category, select: {c.name, c.id}

    query
    |> Repo.all()
  end
end