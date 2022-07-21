# Monitor models with Azure Machine Learning
<https://docs.microsoft.com/en-us/learn/modules/monitor-models-with-azure-machine-learning/>

## Application Insights
- resource for telemetry logging
- associate workspace with existing App. Ins. or a new one will be created
  - check associated resource: `ws.get_details()['applicationInsights']`
- enable App. Ins. when deploying service: `[...].deploy_configuration(..., enable_app_insights=True)`
  - enable on existing service:
    - modify deployment config for AKS in Azure Portal
    - `service.update(enable_app_insights=True)`
### Capture and view telemetry
- write log data
  - just write to standard output with `print`
    - custom dimension in App. Ins. for such output
- query logs
  - SQL-like syntax (looks like KQL...)