
require 'bundler/setup'
# require 'yajl/json_gem'
require 'tire'


s = Tire.search('device_logs/log') do
  query do
  	boolean do
  		must   { string 'message:IO*' }
  	end
  end
end



puts "s curl is #{s.to_curl}"

s.results.each do |document|
  puts "log_id -> #{document.log_id} & document message -> #{document.message}"
end