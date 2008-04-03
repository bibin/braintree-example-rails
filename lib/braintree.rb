require 'digest/md5'
module Braintree
  module Helpers
    def request_hash(orderid, amount, time, key)
      string_to_hash = [orderid, amount, time, key].join("|")
      tr_hash = Digest::MD5.hexdigest(string_to_hash)
      return tr_hash
    end

    def response_hash(orderid, amount, response, transactionid, avsresponse, cvvresponse, time, key)
      string_to_hash = [orderid, amount, response, transactionid, avsresponse, cvvresponse, time, key].join("|")
      tr_hash = Digest::MD5.hexdigest(string_to_hash)
      return tr_hash
    end

    def formatted_utc_time
      Time.now.getutc.strftime("%Y%m%d%H%M%S")
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
end
