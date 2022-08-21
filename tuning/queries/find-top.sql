/*

how to use
1. connect to the db you want to view stats for
2. select an order by enter 
3. run

*/


DECLARE
     @TopRows           TINYINT = 10 -- integer greater than 0
    ,@MostExecuted      BIT = 1 -- 0,1
    ,@LeastExecuted     BIT = 0 -- 0,1
    ,@OrderByTotalCPU   BIT = 0 -- 0,1
    ,@OrderByAvgCPU     BIT = 0 -- 0,1

SELECT TOP (@TopRows)
     OBJECT_NAME(objectid) [object_name]
    ,text
    ,creation_time
    ,last_execution_time
    ,execution_count
    ,(total_worker_time+0.0)/1000 total_cpu
    ,(total_worker_time+0.0)/(execution_count*1000) avg_cpu
    ,*
FROM 
    sys.dm_exec_query_stats qs
CROSS APPLY 
    sys.dm_exec_sql_text(sql_handle) st
ORDER BY
    CASE
        WHEN @MostExecuted = 1 THEN execution_count 
        WHEN @OrderByTotalCPU = 1 THEN (total_worker_time+0.0)/1000
        WHEN @OrderByAvgCPU = 1 THEN (total_worker_time+0.0)/(execution_count*1000)
    END DESC,
    CASE
        WHEN @LeastExecuted = 1 THEN execution_count 
    END ASC
