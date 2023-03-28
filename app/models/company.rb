# frozen_string_literal: true

class Company < ApplicationRecord
  belongs_to :postal_code

  validates :business_id, uniqueness: { case_sensitive: false }
end
