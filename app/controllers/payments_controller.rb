require 'digest/md5'
class PaymentsController < ApplicationController

  def index
    
  end

  def new
    @now = Time.now
    
    @time = @now.getutc.strftime("%Y%m%d%H%M%S")
    @amount = 5000.0
    @orderid = "123456"
    key = "Zydpf74pK59Gc85vpu6r9My286BUYw3q"
    @key_id = "557218"
#    @key_id = "582444"
#    key = "pwngFha662YxZuZ6eh5jr2kem3ZkM6n8"

    @to_hash = [@orderid, @amount, @time, key].join("|")
    @hash = Digest::MD5.hexdigest(@to_hash)
  end

  def gateway_response
    @params = params
    render :template => "payments/response"
  end
end
