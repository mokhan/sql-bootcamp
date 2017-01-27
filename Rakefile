require 'rubygems'
require 'bundler'
Bundler.require(:default)

DATABASE_NAME = 'sql_bootcamp'
DATABASE = Sequel.connect("mysql2://root@localhost/#{DATABASE_NAME}")

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

    if args[:version]
      puts "Migrating to version #{args[:version]}"
      Sequel::Migrator.run(DATABASE, "db/migrations", target: args[:version].to_i)
    else
      puts "Migrating to latest"
      Sequel::Migrator.run(DATABASE, "db/migrations")
    end
  end

  task :seed do
    require_relative 'db/seeds.rb'
    Seeds.new(DATABASE).run
  end

  desc "drop, create and migrate the database"
  task :reset => [:drop, :create, :migrate, :seed]
end
