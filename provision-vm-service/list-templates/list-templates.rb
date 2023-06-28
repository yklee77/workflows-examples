#!/usr/bin/env ruby

require "manageiq-api-client"

secrets = JSON.load(File.read(ENV.fetch("SECRETS")))

api_user     = secrets.fetch("api_user", "admin")
api_password = secrets.fetch("api_password", "smartvm")

api_url = ENV.fetch("api_url", "http://localhost:3000")
ems_id  = ENV.fetch("provider_id")

api = ManageIQ::API::Client.new(:url => api_url, :user => api_user, :password => api_password)

resources = api.templates.where(:ems_id => ems_id).pluck(:ems_ref, :name)

puts({"values" => resources.to_h}.to_json)
