class CreateTenants < ActiveRecord::Migration[6.1]
  def change
    create_table :tenants do |t|
      t.string :surname
      t.string :other_names
      t.string :marital_status
      t.string :phone_number
      t.string :id_number

      t.timestamps
    end
  end
end
