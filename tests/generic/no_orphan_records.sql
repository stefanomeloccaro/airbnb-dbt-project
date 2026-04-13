-- Custom generic test
{% test no_orphan_records(model, column_name, ref_model, ref_column) %}

SELECT 
    m.*
FROM {{ model }} AS m
LEFT JOIN {{ ref_model}} AS r ON m.{{column_name}} = r.{{ref_column}}
WHERE r.{{ ref_column }} IS NULL

{% endtest %}