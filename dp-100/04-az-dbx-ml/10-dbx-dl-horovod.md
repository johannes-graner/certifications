# Distributed deep learning with Horovod and Azure Databricks
<https://docs.microsoft.com/en-us/learn/modules/distributed-deep-learning-horovod-azure-databricks/>

## Horovod
- open-source distributed training framework
  - builds on MPI
    - Spark compatibility through `HorovodRunner` in Databricks
    - uses worker-to-worker communication to avoid bottleneck at driver
  - APIs for TensorFlow, PyTorch, and Keras
### Horovod process
- explore models on single node using TF, PT, or Keras
- migrate code to Horovod
  - initalize Horovod: `hvd.init()`
  - pin one GPU per process (if using GPUs)
  - specify partitioning/sampling
    - all subsets should have equal size
    - Petastorm for parquet
  - scale learning rate by no. workers
    - makes sure weights are adjusted properly at end of epoch
  - Horovod distribution optimizer handles worker-to-worker communication
  - broadcast initial params
  - checkpoint only on worker 0 to avoid conflicts
- distribute with HorovodRunner