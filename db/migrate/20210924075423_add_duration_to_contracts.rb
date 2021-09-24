class AddDurationToContracts < ActiveRecord::Migration[6.1]
  def change
    add_column :contracts, :duration, :string
  end
end
