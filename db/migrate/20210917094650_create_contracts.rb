class CreateContracts < ActiveRecord::Migration[6.1]
  def change
    create_table :contracts do |t|
      t.datetime :start_date
      t.datetime :end_date
      t.references :tenant, null: false, foreign_key: true
      t.references :rental, null: false, foreign_key: true

      t.timestamps
    end
  end
end
