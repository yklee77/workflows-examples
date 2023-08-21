{
  "Comment": "List Templates.",
  "StartAt": "ListTemplates",
  "States": {
    "ListTemplates": {
      "Type": "Task",
      "Resource": "docker://docker.io/agrare/list-templates:latest",
      "End": true,
      "Credentials": {
        "api_user.$": "$.api_user",
        "api_password.$": "$.api_password"
      },
      "Parameters": {
        "API_URL": "https://9.37.205.139",
        "PROVIDER_ID.$": "$.dialog.dialog_provider",
        "VERIFY_SSL": false
      }
    }
  }
}
