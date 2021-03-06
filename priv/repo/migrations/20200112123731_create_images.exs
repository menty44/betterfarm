defmodule Betterfarm.Repo.Migrations.CreateImages do
  use Ecto.Migration

  def change do
    create table(:images) do
      add :avatar, :string
      add :uuid, :string
      add :product_id, references(:products, on_delete: :delete_all)
    end
  end
end
