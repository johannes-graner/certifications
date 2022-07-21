# Work with Data in Azure Machine Learning
< https://docs.microsoft.com/en-us/learn/modules/work-with-data-in-aml/>

## Datastores
- abstraction for cloud data source
  - e.g. Az Storage, ADL, Az SQL DB, Az DBFS
- built-in datastores
  - storage blob container (system storage)
  - storage file container (system storage)
  - sample datastore (only if you use sample datasets)
- register in AML Studio UX or SDK
  - `Datastore.register_azure_blob_container(...)`
- use in SDK:
  - list: `ws.datastores`
  - get: `Datastore.get(ws, datastore_name=...)`
    - `ws.get_default_datastore()`
- considerations
  - premium blob storage improve I/O, but is more expensive
  - parquet > csv
  - can change default datastore for easy access
    - `ws.set_default_datastore(...)`

## Datasets
- versioned data objects
- support data labeling and drift monitoring
- types
  - tabular (structured)
  - file (semi- or unstructured)
- create/register datasets
  - supports path globbing
  - register to make available for other experiments and pipelines
  - tabular:
    - `Dataset.Tabular.from_delimited_files(path=...).register(ws, name=...)`
      - `path` is list of tuples `(datastore, globbed path)`
  - file:
    - `Dataset.File.from_files(path=...).register(ws, name=...)`
- retrieve dataset (two ways)
  - `ws.datasets[name]`
  - `Dataset.get_by_name(ws, name)`
- versioning
  - `ds.register(ws, name=..., create_new_version=True)`
  - `Dataset.get_by_name(ws, name, version=...)`
### Using datasets
#### Tabular
- directly cast tabular datasets to Pandas or Spark
- pass tab. ds to script
  - pass ds id as argument OR
  - named input: 
    - `ScriptRunConfig`: `arguments=['--ds', tab_ds.as_named_input('my_ds')]`
    - Script: `run.input_datasets['my_ds']`
      - still have to parse input argument
#### File
- `file_ds.to_path()` to list all file paths in dataset
- pass to script:
  - two modes: `.as_mount` or `.as_download`
    - `as_download`: most cases, copies to temp location on compute
    - `as_mount`: large dataset, stream files from source
  - can put `.as_named_input(...)` before mode
    - `args.dataset_folder()` to get dir for files
