class AddPostIdToCategory < ActiveRecord::Migration
  def change
  	add_reference :categories, :post, index: true
  end
end
