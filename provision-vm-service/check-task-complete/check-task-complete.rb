#!/usr/bin/env ruby

require "rbvmomi"
require "json"

secrets = JSON.load(File.read(ENV.fetch("SECRETS")))

vcenter_host     = ENV.fetch("vcenter_host")
vcenter_user     = secrets["vcenter_user"]
vcenter_password = secrets["vcenter_password"]

task_ref = ENV.fetch("task")

vim = RbVmomi::VIM.connect(
  host: vcenter_host,
  user: vcenter_user,
  password: vcenter_password,
  insecure: true
)

task = RbVmomi::VIM::Task(vim, task_ref)

result = {
  "state" => task.info.state,
  "vm"    => task.info.result&._ref
}

vim.close

puts result.to_json
