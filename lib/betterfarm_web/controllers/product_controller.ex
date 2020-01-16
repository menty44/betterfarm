defmodule BetterfarmWeb.ProductController do
  use BetterfarmWeb, :controller

  alias Betterfarm.Product
  alias Betterfarm.ProductAccount

  plug :authenticate when action in [:new, :index]

  def new(conn, %{"farmer_id" => farmer_id}) do
    changeset = ProductAccount.change_product(%Product{})
    render(conn, "new.html", changeset: changeset, farmer_id: farmer_id)
  end

  def create(conn, %{"product" => product, "farmer_id" => farmer_id}) do
    attrs = Map.merge(product, %{"farmer_id" => farmer_id})

    case ProductAccount.create_product(attrs) do
      {:ok, product} ->
        ProductAccount.copy_images(attrs["image"], product.id) |> IO.inspect(label: "cheeeeeeeck")

        conn
        |> put_flash(:info, "product added successfully")
        |> redirect(to: Routes.farmer_product_path(conn, :index, farmer_id))

      {:error, changeset} ->
        conn
        |> put_flash(:error, "Something went wrong, Try Again")
        |> render("new.html", changeset: changeset, farmer_id: farmer_id)
    end
  end

  def index(conn, _param) do
    render(conn, "index.html")
  end
end
