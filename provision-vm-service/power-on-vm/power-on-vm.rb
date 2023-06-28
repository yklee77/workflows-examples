#!/usr/bin/env ruby

require "json"
require "rbvmomi"

secrets = JSON.load(File.read(ENV.fetch("SECRETS")))

vcenter_host     = ENV.fetch("vcenter_host")
vcenter_user     = secrets["vcenter_user"]
vcenter_password = secrets["vcenter_password"]

vm_ref = ENV.fetch("vm")

vim = RbVmomi::VIM.connect(
  host: vcenter,
  user: user,
  password: password,
  insecure: true
)

vm = RbVmomi::VIM::VirtualMachine(vim, vm_ref)
task = vm.PowerOnVM_Task

result = {"task_id": task._ref}.to_json

vim.close

puts result
