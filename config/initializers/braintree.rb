braintree_configs = YAML.load_file("#{RAILS_ROOT}/config/braintree.yml")
BRAINTREE = { }
braintree_configs.each do |k,v|
  BRAINTREE[k.intern] = v
end
      

