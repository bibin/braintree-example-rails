require 'digest/md5'
require File.dirname(__FILE__) + '/../test_helper'

class GatewayResponseTest < ActiveSupport::TestCase
  def test_should_create_a_valid_hash
    response = GatewayResponse.new
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

  def successful_transaction_attributes
  end

  def failed_transaction_attributes
  end
end
