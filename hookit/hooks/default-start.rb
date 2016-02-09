
service 'cache' do
  action :enable
  init :runit
end

ensure_socket 'cache' do
  port '11211'
  action :listening
end
