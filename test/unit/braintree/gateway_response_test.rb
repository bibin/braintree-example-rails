require File.dirname(__FILE__) + '/../../test_helper'

class Braintree::GatewayResponseTest < ActiveSupport::TestCase

  def test_should_create_a_valid_hash
    response = Braintree::GatewayResponse.new(attributes_to_hash(successful_transaction))
    assert response.is_valid?
  end

  def test_should_be_successful_if_response_is_success
    response = Braintree::GatewayResponse.new(attributes_to_hash(successful_transaction))
    assert response.is_successful?
  end

  def test_should_be_declined_if_response_is_declined
    response = Braintree::GatewayResponse.new(attributes_to_hash(declined_transaction))
    assert response.is_declined?
  end

  def test_should_be_error_if_response_is_error
    response = Braintree::GatewayResponse.new(attributes_to_hash(duplicate_transaction))
    assert response.is_error?
  end

  def test_should_populate_returned_hash
    response = Braintree::GatewayResponse.new(attributes_to_hash(successful_transaction))
    assert_equal response.hash, response.returned_hash
  end

  def test_should_be_approved_if_response_matches
    response = Braintree::GatewayResponse.new(attributes_to_hash(successful_transaction))
    assert_equal "approved", response.response_status
  end

  def test_should_be_declined_if_response_matches
    response = Braintree::GatewayResponse.new(attributes_to_hash(declined_transaction))
    assert_equal "declined", response.response_status
  end

  def test_should_be_error_if_response_matches
    response = Braintree::GatewayResponse.new(attributes_to_hash(duplicate_transaction))
    assert_equal "error", response.response_status
  end

  # TEST_HELPERS
  def test_should_format_proper_response_attributes
    expected = "foo=bar&bah=blah"
    assert_equal expected, response_attributes("foo" => "bar", "bah" => "blah")
  end

  private
  def response_attributes(options)
    attributes_hash = { }.merge(options).delete_if { |k,v| v.nil?}
    attributes_array = []
    attributes_hash.each { |k,v| attributes_array << [k, v].join("=") }
    attributes = attributes_array.join("&")
    return attributes
  end

  def successful_transaction
    "response=1&responsetext=Customer%20Added&authcode=&transactionid=0&avsresponse=&cvvresponse=&orderid=123456&type=&response_code=100&customer_vault_id=1154835797&username=557218&time=20080402213642&amount=50.0&hash=75b4c62134e0bf50bccb3e668f6df291"
  end

  def declined_transaction
    "response=2&responsetext=DECLINE&authcode=&transactionid=674526079&avsresponse=&cvvresponse=&orderid=123456&type=sale&response_code=200&username=557218&time=20080402215134&amount=0.5&hash=66351209cbbda9fca6d81e57f6313562"
  end

  def duplicate_transaction
    "response=3&responsetext=Duplicate%20Customer%20Vault%20Id&authcode=&transactionid=0&avsresponse=&cvvresponse=&orderid=1&type=&response_code=300&customer_vault_id=236846573&username=557218&time=20080401110844&amount=1.0&hash=d5ca5430aad0cc4b53f89da2f57c373f"
  end

  def fuxored_hash_transaction
  end

  def attributes_to_hash(string)
    attributes = { }
    
    string.split("&").each do |pair|
      pair_array = pair.split("=")
      attributes[pair_array[0].intern] = pair_array[1]
    end
    
    return attributes
  end
end
