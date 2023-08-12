#!/usr/bin/env ruby

require "manageiq-api-client"

secrets = JSON.load(File.read(ENV.fetch("SECRETS")))

user     = secrets.fetch("api_user", "admin")
password = secrets.fetch("api_password", "smartvm")

url           = ENV.fetch("API_URL", "http://localhost:3000")
provider_type = ENV.fetch("PROVIDER_TYPE", nil)

api = ManageIQ::API::Client.new(:url => url, :user => user, :password => password)

response = api.providers
response = response.where(:type => provider_type) if provider_type
response = response.pluck(:id, :name)

puts({"values" => response.to_h}.to_json)
