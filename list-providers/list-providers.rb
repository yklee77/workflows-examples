#!/usr/bin/env ruby

require "manageiq-api-client"

secrets = JSON.load(File.read(ENV.fetch("SECRETS")))

user     = secrets.fetch("user", "admin")
password = secrets.fetch("password", "smartvm")

url           = ENV.fetch("api_url", "http://localhost:3000")
provider_type = ENV.fetch("provider_type", nil)

api = ManageIQ::API::Client.new(:url => url, :user => user, :password => password)

response = api.providers
response = response.where(:type => provider_type) if provider_type
response = response.pluck(:id, :name)

puts({"values" => response.to_h}.to_json)
