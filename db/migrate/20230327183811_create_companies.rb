# frozen_string_literal: true

class CreateCompanies < ActiveRecord::Migration[7.0]
  def change
    create_table :companies do |t|
      t.string :business_id, null: false
      t.string :name, null: false
      t.datetime :registration_date, null: false
      t.string :company_form, null: false
      t.string :details_uri
      t.belongs_to :postal_code, index: true
      t.timestamps
    end
    add_index :companies, :business_id, unique: true
  end
end
