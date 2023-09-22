{
  "Comment": "List providers.",
  "StartAt": "ListProviders",
  "States": {
    "ListProviders": {
      "Type": "Task",
      "Resource": "docker://docker.io/agrare/list-providers:latest",
      "End": true,
      "Credentials": {
        "api_user.$": "$.api_user",
        "api_password.$": "$.api_password"
      },
      "Parameters": {
        "API_URL": "https://9.37.205.139",
        "PROVIDER_TYPE.$": "ManageIQ::Providers::Vmware::InfraManager",
        "VERIFY_SSL": false
      }
    }
  }
}
