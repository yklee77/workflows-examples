{
  "Comment": "List Templates.",
  "StartAt": "ListTemplates",
  "States": {
    "ListTemplates": {
      "Type": "Task",
      "Resource": "docker://docker.io/agrare/list-templates:latest",
      "End": true,
      "Credentials": {
        "api_user": "$.api_user",
        "api_password": "$.api_password"
      },
      "Parameters": {
        "provider_id": "$.dialog_provider"
      }
    }
  }
}
