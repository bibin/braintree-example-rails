module OrdersHelper
  def transparent_redirect_hidden_fields
    content_tag :div, :style => "margin:0;padding:0;" do 
      hidden_field_tag('type', "sale")                 +
        hidden_field_tag('orderid', @order.id)         +
        hidden_field_tag('amount', @order.amount)      +
        hidden_field_tag('time', @time)                +
        hidden_field_tag('hash', @tr_hash)             +
        hidden_field_tag('key_id', BRAINTREE[:key_id]) +
        hidden_field_tag('redirect', gateway_response_order_url(@order))
    end
  end

  def secure_vault_hidden_fields
    content_tag :div, :style => "margin:0;padding:0;" do 
      hidden_field_tag('customer_vault', 'add_customer')
    end
  end
end
