{
  "Comment": "List providers.",
  "StartAt": "ListProviders",
  "States": {
    "ListProviders": {
      "Type": "Task",
      "Resource": "docker://docker.io/agrare/list-providers:latest",
      "End": true,
      "Credentials": {
        "api_user": "$.api_user",
        "api_password": "$.api_password"
      },
      "Parameters": {
        "provider_type": "ManageIQ::Providers::Vmware::InfraManager"
      }
    }
  }
}
