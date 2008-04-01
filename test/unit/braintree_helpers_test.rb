require File.dirname(__FILE__) + '/../test_helper'
require File.dirname(__FILE__) + '/../../lib/braintree'

class Braintree::HelpersTest < ActiveSupport::TestCase
  include Braintree::Helpers

  def test_should_have_helpers
    assert Braintree::Helpers.is_a?(Module)
  end

  def test_should_generate_hash
    to_hash = [ attrs[:orderid], attrs[:amount], 
                attrs[:time],    attrs[:key]   ].join("|")
    expected = Digest::MD5.hexdigest(to_hash)
    assert_equal expected, hash_value(attrs[:orderid], attrs[:amount], attrs[:time], attrs[:key])
  end

  def test_should_generate_proper_time
    # FIXME: this test doesn't really do anything...
    actual = formatted_utc_time
    assert_not_nil actual
  end
  
  private
  def attrs
    {  :orderid => 1,
       :amount  => 1.00,
       :time    => "20080324123456",
       :key     => "123456"
    }
  end
end
