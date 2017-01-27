require 'json'
require 'prime'

class Seeds
  attr_reader :database, :event_types

  def initialize(database)
    @database = database
    @event_types = (1..5).to_a
    @threads = []
  end

  def run
    10.times do
      background_thread do
        rand(100).times do
          rand(50).times do
            puts "creating"
            database[:events].insert(
              computer_id: create_computer(business_id: create_business(name: FFaker::Company.name)),
              occurred_at: DateTime.parse(FFaker::Time.datetime),
              type: event_types.sample,
              data: JSON.generate({
                ip_address: FFaker::Internet.ip_v4_address,
                mac: FFaker::Internet.mac,
                url: FFaker::Internet.http_url,
              })
            )
          end
        end
      end
    end
  ensure
    @threads.map(&:join)
  end

  private

  def background_thread(&block)
    @threads << Thread.new(&block)
  end

  def create_computer(active: rand(100).even?, business_id:)
    database[:computers].insert(active: active, business_id: business_id)
  end

  def create_business(name:)
    database[:businesses].insert(name: name, business_relationship_id: rand(3))
  end
end
