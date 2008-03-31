module OrdersHelper
  def transparent_redirect_hidden_fields
    hidden_field_tag('orderid', @order.id)    +
    hidden_field_tag('amount', @order.amount) +
    hidden_field_tag('time', @time)           +
    hidden_field_tag('hash', @tr_hash)        +
    hidden_field_tag('key_id', @key_id)       +
    hidden_field_tag('redirect', orders_url)
  end
end
