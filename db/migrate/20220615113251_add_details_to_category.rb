class AddDetailsToCategory < ActiveRecord::Migration[6.1]
  def change
    add_column :categories, :details, :string
  end
end
