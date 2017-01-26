require 'json'

businesses = DATABASE[:businesses]
computers = DATABASE[:computers]
events = DATABASE[:events]
event_types = (1..5).to_a

10.times do
  business_id = businesses.insert(name: FFaker::Company.name, business_relationship_id: rand(3))

  10.times do
    computer_id = computers.insert(active: rand(100).even?, business_id: business_id)

    10.times do
      data = JSON.generate({
        ip_address: FFaker::Internet.ip_v4_address,
        mac: FFaker::Internet.mac,
        url: FFaker::Internet.http_url,
      })
      events.insert(computer_id: computer_id, occurred_at: DateTime.parse(FFaker::Time.datetime), type: event_types.sample, data: data)
    end
  end
end
