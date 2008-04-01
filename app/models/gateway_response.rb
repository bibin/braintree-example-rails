require 'digest/md5'
class GatewayResponse

  attr_accessor :response, :response_text, :response_code, :gateway_response, :cvv_response, :avs_response, :hash, :time, :orderid, :amount, :transactionid, :authcode, :username

  def is_successful?
  end

  def is_valid?
    check_hash
  end

  def check_hash
    @string_to_hash = [self.orderid, self.amount, self.time, BRAINTREE[:key]].join("|")
    expected = Digest.MD5.hexdigest
    raise unless expected == self.hash
    return true
  end

end
