require 'digest/md5'
class PaymentsController < ApplicationController

#  before_filter :set_hash_variables, :except => [ :index, :gateway_response ]

  def index
    # render index.html.erb
  end

  def new
    @amount = 0.50
    @type = "sale"
    @orderid = "123456"

       @now = Time.now
    
    @time = @now.getutc.strftime("%Y%m%d%H%M%S")

    key = "Zydpf74pK59Gc85vpu6r9My286BUYw3q"
    @key_id = "557218"

    @to_hash = [@orderid, @amount, @time, key].join("|")
    @hash = Digest::MD5.hexdigest(@to_hash)
  end

  def edit
    @customerid = "236846573"
    @amount = 1.00
    @orderid = 1

       @now = Time.now
    
    @time = @now.getutc.strftime("%Y%m%d%H%M%S")

    key = "Zydpf74pK59Gc85vpu6r9My286BUYw3q"
    @key_id = "557218"

    @to_hash = [@orderid, @amount, @time, key].join("|")
    @hash = Digest::MD5.hexdigest(@to_hash)
  end

  def gateway_response
    @params = params
    render :template => "payments/response"
  end

  private
  def set_hash_variables
    @now = Time.now
    
    @time = @now.getutc.strftime("%Y%m%d%H%M%S")

    key = "Zydpf74pK59Gc85vpu6r9My286BUYw3q"
    @key_id = "557218"

    @to_hash = [@orderid, @amount, @time, key].join("|")
    @hash = Digest::MD5.hexdigest(@to_hash)
  end
end
