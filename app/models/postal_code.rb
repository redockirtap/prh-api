# frozen_string_literal: true

class PostalCode < ApplicationRecord
  has_many :companies

  validates :postal_code, uniqueness: { case_sensitive: false }
end
