require 'rest-client'

class PrhDataService
  def fetch_data
    postal_codes.each_with_object([]) do |postal_code, companies|
      url_params = { streetAddressPostCode: postal_code, maxResults: ENV['MAX_RESULTS'] }
      response = RestClient.get(ENV['BASE_URL'], params: url_params)
      postal_code_companies = JSON.parse(response.body)['results']
      postal_code_companies.each { |company| companies << company }
      save_postal_codes(postal_code)
      save_companies(companies, postal_code)
    end
  end

  private

  def save_postal_codes(postal_code)
    @postal_code = PostalCode.new(postal_code: postal_code)
    @postal_code.update(postal_code: postal_code)
  end

  def save_companies(companies, postal_code)
    companies.each do |company|
      @postal_code = PostalCode.find_by(postal_code: postal_code)
      @company = Company.new(business_id: company['businessId'], postal_code_id: @postal_code.id)

      @company.update(name: company['name'],
                      business_id: company['businessId'],
                      registration_date: company['registrationDate'],
                      company_form: company['companyForm'],
                      details_uri: company['detailsUri'],
                      postal_code_id: @postal_code.id)
    end
  end

  def postal_codes
    ENV['POSTAL_CODES']&.split(',')&.map(&:strip) || []
  end
end
