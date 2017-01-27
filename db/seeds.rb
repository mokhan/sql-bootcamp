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
    100.times { create_business }
    10_000.times { create_computer }
    25_000.times { create_event }
  ensure
    @threads.map(&:join)
  end

  private

  def background_thread(&block)
    @threads << Thread.new(&block)
  end

  def create_computer(active: rand(100).even?, business: random_business)
    database[:computers].insert(active: active, business_id: business[:id])
  end

  def create_business(name: FFaker::Company.name)
    database[:businesses].insert(name: name, business_relationship_id: rand(3))
  end

  def create_event(computer: random_computer)
    database[:events].insert(
      computer_id: computer[:id],
      occurred_at: DateTime.parse(FFaker::Time.datetime),
      type: event_types.sample,
      data: JSON.generate({
        ip_address: FFaker::Internet.ip_v4_address,
        mac: FFaker::Internet.mac,
        url: FFaker::Internet.http_url,
      })
    )
  end

  def random_business
    database[:businesses].limit(1).offset(rand(database[:businesses].count)).first
  end

  def random_computer
    database[:computers].limit(1).offset(rand(database[:computers].count)).first
  end
end
