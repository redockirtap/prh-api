# frozen_string_literal: true

require 'rest-client'

class PrhDataService
  def fetch_data
    postal_codes.map do |postal_code|
      companies = fetch_companies(postal_code)
      save_postal_codes(postal_code)
      save_companies(companies, postal_code)
    end
  end

  private

  def fetch_companies(postal_code)
    url_params = { streetAddressPostCode: postal_code, maxResults: ENV['MAX_RESULTS'] }
    res = RestClient.get(ENV['BASE_URL'], params: url_params)
    JSON.parse(res.body)['results']
  end

  def save_postal_codes(postal_code)
    return if PostalCode.find_by(postal_code:)

    PostalCode.create(postal_code:)
  end

  def save_companies(companies, postal_code)
    companies.each do |company|
      next if Company.find_by(business_id: company['businessId'])

      create_company_record(company, postal_code)
    end
  end

  def create_company_record(company, postal_code)
    @postal_code = PostalCode.find_by(postal_code:)

    Company.create(name: company['name'],
                   business_id: company['businessId'],
                   registration_date: company['registrationDate'],
                   company_form: company['companyForm'],
                   details_uri: company['detailsUri'],
                   postal_code_id: @postal_code.id)
  end

  def postal_codes
    ENV['POSTAL_CODES']&.split(',')&.map(&:strip) || []
  end
end
