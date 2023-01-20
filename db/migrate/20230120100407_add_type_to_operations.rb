class AddTypeToOperations < ActiveRecord::Migration[7.0]
  def change
    add_column :operations, :type, :integer
  end
end
