class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name
      t.string :subname
      t.text :activity
      t.string :legal_form
      t.text :registration_number
      t.references :head_office

      t.timestamps
    end
    add_index :companies, :head_office_id
  end
end
