class AddUserIdToDislikes < ActiveRecord::Migration
  def change
    add_reference :dislikes, :user, index: true
  end
end
