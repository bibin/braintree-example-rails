module OrdersHelper
  def gateway_request_hidden_fields(gateway_request)
    content_tag :div, :style => "margin:0;padding:0;" do 
      hidden_field_tag('type', gateway_request.type)       +
      hidden_field_tag('key_id', gateway_request.key_id)   +
      hidden_field_tag('orderid', gateway_request.orderid) +
      hidden_field_tag('amount', gateway_request.amount)   +
      hidden_field_tag('time', gateway_request.time)       +
      hidden_field_tag('hash', gateway_request.hash)       +
      hidden_field_tag('redirect', gateway_request.response_url) +
      hidden_field_tag('customer_vault', gateway_request.customer_vault)
    end
  end
end
