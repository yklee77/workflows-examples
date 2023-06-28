#!/usr/bin/env ruby

require "pathname"
require "json"
require "rbvmomi"

secrets = JSON.load(File.read(ENV.fetch("SECRETS")))

api_user     = secrets.fetch("api_user", "admin")
api_password = secrets.fetch("api_password", "smartvm")

api_url      = ENV.fetch("api_url", "http://localhost:3000")
ems_id       = ENV.fetch("provider_id")
template_ref = ENV.fetch("template")
folder_ref   = ENV.fetch("folder", nil)
host_ref     = ENV.fetch("host", nil)
pool_ref     = ENV.fetch("respool", nil)
vm_name      = ENV.fetch("name")

require "manageiq-api-client"
api = ManageIQ::API::Client.new(:url => api_url, :user => api_user, :password => api_password)

vcenter_host = api.providers.pluck(:id, :hostname).detect { |id, _| id == ems_id }.last

vim = RbVmomi::VIM.connect(
  host: vcenter_host,
  user: secrets["vcenter_user"],
  password: secrets["vcenter_password"],
  insecure: true
)

template = RbVmomi::VIM::VirtualMachine(vim, template_ref)

folder_ref ||= template.parent._ref
host_ref   ||= template.runtime.host._ref
pool_ref   ||= template.runtime.host.parent.resourcePool._ref

spec = RbVmomi::VIM::VirtualMachineCloneSpec(
  location: RbVmomi::VIM::VirtualMachineRelocateSpec(
    host: host_ref,
    pool: pool_ref
  ),
  powerOn: false,
  template: false
)

task = template.CloneVM_Task(folder: folder_ref, name: vm_name, spec: spec)
result = {"task": task._ref, "vcenter_host": vcenter_host}.to_json

vim.close

puts result
