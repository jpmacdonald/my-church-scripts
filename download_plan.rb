require 'pco_api'
require 'pp'
require 'json'

app_id = '<API ID>'
secret = '<API_SECRET>'
api = PCO::API.new(basic_auth_token: app_id, basic_auth_secret: secret)

service = api.services.v2.service_types[349021]
name = service.get['data']['attributes']['name']
plans = service.plans.get(include:'my_schedules', filter: 'future')
earliest_plan_id = plans['data'][0]['id']
earliest_plan_date = plans['data'][0]['attributes']['dates']
earliest_plan = service.plans[earliest_plan_id]['items']

File.open("plan.json","w") do |f|
    f.write(earliest_plan.get.to_json)
end

puts 'Retrieved:'
puts  name + ' ' + earliest_plan_date
 