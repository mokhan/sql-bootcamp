require 'rubygems'
require 'bundler'
Bundler.require(:default)

DATABASE_NAME = 'sql_bootcamp'

#| BUSINESSES               |              | COMPUTERS   |         | EVENTS      |              |
#| id                       | int          | id          | int     | id          | int          |
#| name                     | varchar(255) | active      | tinyint | computer_id | int          |
#| business_relationship_id | int          | business_id | int     | occurred_at | datetime     |
#|                          |              |             |         | type        | varchar(255) |
#|                          |              |             |         | data        | text         |

namespace :db do
  def pipe_to_mysql(command)
    `echo "#{command}" | mysql -u root`
  end

  desc "create database"
  task :create do
    pipe_to_mysql("CREATE DATABASE #{DATABASE_NAME}")
  end

  desc "drop database"
  task :drop do
    pipe_to_mysql("DROP DATABASE IF EXISTS #{DATABASE_NAME}")
  end

  desc "Run migrations"
  task :migrate, [:version] do |t, args|
    Sequel.extension :migration
    db = Sequel.connect("mysql2://root@localhost/#{DATABASE_NAME}")

    if args[:version]
      puts "Migrating to version #{args[:version]}"
      Sequel::Migrator.run(db, "db/migrations", target: args[:version].to_i)
    else
      puts "Migrating to latest"
      Sequel::Migrator.run(db, "db/migrations")
    end
  end

  task :reset => [:drop, :create, :migrate] do

  end
end
