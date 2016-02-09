
service 'cache' do
  action :disable
  init :runit
end
