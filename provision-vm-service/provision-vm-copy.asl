{
  "Comment": "Provision a VMware VM.",
  "StartAt": "CloneTemplate",
  "States": {
    "CloneTemplate": {
      "Type": "Task",
      "Resource": "docker://docker.io/agrare/clone-template:latest",
      "Next": "CheckTaskComplete",
      "Parameters": {
        "provider_id": "$.attrs.dialog_provider",
        "template": "$.attrs.dialog_source_template",
        "name": "$.attrs.dialog_vm_name"
      }
    },

    "CheckTaskComplete": {
      "Type": "Task",
      "Resource": "docker://docker.io/agrare/check-task-complete:latest",
      "Next": "PollTaskComplete",
      "Parameters": {
        "vcenter_host": "$.vcenter_host",
        "task": "$.task"
      }
    },

    "PollTaskComplete": {
      "Type": "Choice",
      "Choices": [
        {
          "Variable": "$.state",
          "StringEquals": "running",
          "Next": "RetryState"
        },
        {
          "Variable": "$.state",
          "StringEquals": "success",
          "Next": "PowerOnVM"
        },
        {
          "Variable": "$.state",
          "StringEquals": "error",
          "Next": "FailState"
        }
      ],
      "Default": "FailState"
    },

    "RetryState": {
      "Type": "Wait",
      "Seconds": 5,
      "Next": "CheckTaskComplete"
    },

    "PowerOnVM": {
      "Type": "Task",
      "Resource": "docker://docker.io/agrare/power-on-vm:latest",
      "Next": "SuccessState",
      "Parameters": {
        "vcenter_host": "$.vcenter_host",
        "vm": "$.vm"
      }
    },

    "SuccessState": {
      "Type": "Succeed"
    },

    "FailState": {
      "Type": "Fail",
      "Error": "FailStateError",
      "Cause": "No Matches!"
    }
  }
}
