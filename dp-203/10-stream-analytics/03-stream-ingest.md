# Ingest data streams with Azure Stream Analytics
[https://docs.microsoft.com/en-us/learn/modules/ingest-data-streams-with-azure-stream-analytics]

## Windowing
- tumbling (just standard windows)
  - contiguous series
  - fixed-size, non-overlapping
  - event belongs to exactly one window
  - `GROUP BY TumblingWindow(minute, 10)`
    - exclusive beginning, inclusive end
  - output at end of windows
- hopping
  - fixed-size, overlapping
  - basically overlapping tumbling
  - event belongs to at least one window
  - `GROUP BY HoppingWindow(minute, 10, 5)`
    - hops every 5 minutes
- sliding
  - fixed-size
  - new window every time event is created
    - window contains all points received less than <size> time ago
  - event belongs to at least one window
  - `GROUP BY SlidingWindow(minute, 10) HAVING COUNT(*) > 3`
    - windows are 10 min long, only windows with 4 or more events are considered
- session
  - variable-size, non-overlapping
  - clusters events received at similar times
  - timeout is max distance between neighboring events in window
  - maximum duration
  - can specify partitioning key
  - `GROUP BY Username, SessionWindow(minute, 2, 10) OVER (PARTITION BY Username)`
    - 2 min timeout, 10 min max duration
    - partitioned by Username
- snapshot
  - group by identical timestamp values
  - `GROUP BY System.Timestamp()`