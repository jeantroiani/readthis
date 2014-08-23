class RemoveTextFromPost < ActiveRecord::Migration
  def change
    remove_column :posts, :post, :string
  end
end
