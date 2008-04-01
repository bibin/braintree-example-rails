require 'digest/md5'
module Braintree
  module Helpers
    def hash_value(orderid, amount, time, key)
      string_to_hash = [orderid, amount, time, key].join("|")
      tr_hash = Digest::MD5.hexdigest(string_to_hash)
      return tr_hash
    end

    def formatted_utc_time
      Time.now.getutc.strftime("%Y%m%d%H%M%S")
    end
  end
end
