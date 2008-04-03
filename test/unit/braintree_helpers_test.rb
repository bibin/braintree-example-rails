require File.dirname(__FILE__) + '/../test_helper'
require File.dirname(__FILE__) + '/../../lib/braintree'

class Braintree::HelpersTest < ActiveSupport::TestCase
  include Braintree::Helpers

  def test_should_have_helpers
    assert Braintree::Helpers.is_a?(Module)
  end

  def test_should_generate_request_hash
    to_hash = [ attrs[:orderid], attrs[:amount], 
                attrs[:time],    attrs[:key]   ].join("|")
    expected = Digest::MD5.hexdigest(to_hash)
    assert_equal expected, request_hash(attrs[:orderid], attrs[:amount], attrs[:time], attrs[:key])
  end

  def test_should_generate_response_hash
    to_hash = [ attrs[:orderid], attrs[:amount], 
                attrs[:response], attrs[:transactionid],
                attrs[:avsresponse], attrs[:cvvresponse],
                attrs[:time],    attrs[:key]   ].join("|")
    expected = Digest::MD5.hexdigest(to_hash)
    assert_equal expected, response_hash(attrs[:orderid], attrs[:amount], 
       attrs[:response], attrs[:transactionid], attrs[:avsresponse], 
       attrs[:cvvresponse], attrs[:time], attrs[:key])
  end

  def test_should_generate_proper_time
    # FIXME: this test doesn't really do anything...
    actual = formatted_utc_time
    assert_not_nil actual
  end
  
  def test_should_parse_string_into_hash_of_attributes
    string = "foo=bar&bah=blam"
    expected = { :foo => "bar", :bah => "blam" }
    assert_equal expected, attributes_to_hash(string)
  end

  private
  def attrs
    {  :orderid => 1,
       :amount  => 1.00,
       :time    => "20080324123456",
       :key     => "123456",
       :response => "3",
       :avsresponse => "N",
       :cvvresponse => "N"
    }
  end
end
