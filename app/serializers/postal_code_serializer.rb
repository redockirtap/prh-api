# frozen_string_literal: true

class PostalCodeSerializer < ActiveModel::Serializer
  attributes :id, :postal_code, :companies

  def companies
    object.companies.limit(5).pluck(:name, :business_id)
  end
end
