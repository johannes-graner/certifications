# Monitor data drift with Azure Machine Learning
<https://docs.microsoft.com/en-us/learn/modules/monitor-data-drift-with-azure-machine-learning/>

## Data drift
- data profile changes over time
  - makes models less accurate
### Monitoring
- compare datasets
  - baseline
  - target (new data)
    - needs timestamp to measure rate of drift
- dataset monitor
  - `azureml.datadrift.DataDriftDetector`
    - `workspace`
    - `name`
    - `baseline_data_set` (`train_ds`)
    - `target_data_set`
    - `compute_target`
    - `frequency`
      - `Day`, `Week`, or `Month`
    - `feature_list`
      - list of feature column names
    - `latency`
      - no. hours for new data to be collected and added to target
  - compare all in target to baseline: `monitor.backfill(start, end)`
    - `start` and `end` are datetimes between which to compare to baseline
- alerts
  - data drift measured by magnitude
  - magnitude has natural variation, but large changes should be investigated
    - define `AlertConfiguration(email)` and add `drift_threshold` and `alert_configuration` to monitor