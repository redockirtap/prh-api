# frozen_string_literal: true

class CompaniesController < ApplicationController
  def index
    fetch_companies

    @postal_codes = PostalCode.all.includes(:companies)

    if @postal_codes
      render json: @postal_codes, each_serializer: PostalCodeSerializer, status: :ok
    else
      render json: { 'error': @companies.errors.full_messages.to_sentence }, status: 422
    end
  end

  def show
    fetch_companies

    @postal_code = PostalCode.find_by(postal_code: postal_code_params[:postal_code])
    @companies = Company.where(postal_code_id: @postal_code.id).limit(20)

    if @companies
      render json: @companies, status: :ok
    else
      render json: { 'error': @companies.errors.full_messages.to_sentence }, status: 422
    end
  end

  private

  def fetch_companies
    PrhDataService.new.fetch_data
  end

  def postal_code_params
    params.permit(:postal_code)
  end
end
