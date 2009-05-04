require 'digest/md5'
require File.dirname(__FILE__) + '/../../test_helper'

class Braintree::GatewayRequestTest < ActiveSupport::TestCase
  
  def test_should_generate_formatted_time_on_initialize
    request = Braintree::GatewayRequest.new
    assert_not_nil request.time
  end

  def test_should_keep_formatted_time
    request = Braintree::GatewayRequest.new
    time = request.time
    assert_equal time, request.time
  end

  def test_should_assign_key_on_initialize
    request = Braintree::GatewayRequest.new
    assert_not_nil request.key
  end

  def test_should_assign_key_id_on_initialize
    request = Braintree::GatewayRequest.new
    assert_not_nil request.key_id
  end

  def test_should_assign_attributes_to_object_on_initialize
    request = Braintree::GatewayRequest.new(standard_attributes)
    standard_attributes.each_key { |key| assert_not_nil request.send("#{key}")}
  end

  def test_should_calculate_hash_on_initialize
    request = Braintree::GatewayRequest.new(standard_attributes)
    assert_not_nil request.hash
  end

  def test_should_generate_proper_hash_without_customer_vault_id
    request = Braintree::GatewayRequest.new(standard_attributes)
    expected = Digest::MD5.hexdigest([request.orderid, request.amount,
                                      request.time, request.key].join("|"))
    assert_equal expected, request.hash
  end
  
  def test_should_generate_proper_hash_with_customer_vault_id
    request = Braintree::GatewayRequest.new(standard_attributes(:customer_vault_id => 123))
    expected = Digest::MD5.hexdigest([request.orderid, request.amount, request.customer_vault_id,
                                      request.time, request.key].join("|"))
    assert_equal expected, request.hash
  end
  
  private
  def standard_attributes(options = { })
    { :orderid => "1", :amount => 1.00 }.merge(options)
  end
  
end
