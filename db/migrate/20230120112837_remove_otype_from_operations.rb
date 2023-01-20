class RemoveOtypeFromOperations < ActiveRecord::Migration[7.0]
  def change
    remove_column :operations, :otype, :integer
  end
end
