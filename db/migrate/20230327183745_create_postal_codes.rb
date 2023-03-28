# frozen_string_literal: true

class CreatePostalCodes < ActiveRecord::Migration[7.0]
  def change
    create_table :postal_codes do |t|
      t.string :postal_code, null: false

      t.timestamps
    end
    add_index :postal_codes, :postal_code, unique: true
  end
end
