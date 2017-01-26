require 'json'
require 'prime'

pool = Concurrent::FixedThreadPool.new(10)
event_types = (1..5).to_a

10.times do
  business_id = DATABASE[:businesses].insert(name: FFaker::Company.name, business_relationship_id: rand(3))
  puts "Created business: #{business_id}"

  pool.post do
    rand(100).times do |n|
      computer_id = DATABASE[:computers].insert(active: rand(100).even?, business_id: business_id.prime? ? business_id * 42 : business_id)
      puts "Created computer: #{computer_id} on #{Thread.current.object_id}"

      rand(50).times do
        data = JSON.generate({
          ip_address: FFaker::Internet.ip_v4_address,
          mac: FFaker::Internet.mac,
          url: FFaker::Internet.http_url,
        })
        DATABASE[:events].insert(computer_id: computer_id, occurred_at: DateTime.parse(FFaker::Time.datetime), type: event_types.sample, data: data)
      end
    end
  end
end

pool.wait_for_termination
