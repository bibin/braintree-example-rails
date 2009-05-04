require 'digest/md5'
class Braintree::GatewayRequest
  attr_accessor :orderid, :amount, :key, :key_id, :time, :response_url,
                :type, :customer_vault, :customer_vault_id

  attr_reader :hash

  def initialize(attributes = nil)
    attributes.each { |k,v| self.send("#{k}=", v) } unless attributes.nil?
    self.key, self.key_id = BRAINTREE[:key], BRAINTREE[:key_id]
    self.time = self.class.formatted_time_value    
  end

  def hash
    if customer_vault_id.nil?
      Digest::MD5.hexdigest([self.orderid, self.amount, self.time, self.key].join("|"))
    else
      Digest::MD5.hexdigest([self.orderid, self.amount, self.customer_vault_id, self.time, self.key].join("|"))
    end
  end

  def self.formatted_time_value
    Time.now.getutc.strftime("%Y%m%d%H%M%S")
  end

end
