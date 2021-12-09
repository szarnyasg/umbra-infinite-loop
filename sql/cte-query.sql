WITH RECURSIVE
    search_graph(link, level, path) AS (
            SELECT 8796093022357::bigint, 0, ARRAY[8796093022357::bigint]
        UNION ALL (
            WITH sg(sg_link, sg_level) as (select * from search_graph) -- Note: sg is only the diff produced in the previous iteration
            SELECT DISTINCT k_person2id, x.sg_level + 1, array_append(path, k_person2id)
            FROM knows, sg x
            WHERE x.sg_link = k_person1id
            -- stop if we have reached person2 in the previous iteration
            and not exists(select * from sg y where y.sg_link = 8796093022390::bigint)
            -- skip reaching persons reached in the previous iteration
            and not exists(select * from sg y where y.sg_link = k_person2id)
          )
)
select max(depth) AS shortestPathLength from (
    select level as depth
    from search_graph
    where link = 8796093022390
    union all
    select -1
) tmp;
