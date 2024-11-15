select
    item_code,
    model_label,
    count(distinct transaction_id) as transactions,
    sum(gmv_amount) as gmv_amount,
    sum(gmv_item_quantity) as gmv_item_quantity
from
    sales_detail_migration_version
where
    economical_businessunit_country_code = 'ES'
    and retrocession_type != 'Physical'
    and date(gmv_recorded_at) >= date_trunc('WEEK', current_date()) - interval 8 day
    AND date(gmv_recorded_at) < date_trunc('WEEK', current_date()) - interval 1 day
    and item_operation_type = 'sale'
    and item_code != 2102120
    and seller_type = '1P'
    and merchandise_hierarchy_name != 'Rent'
group by
    1,
    2
order by
    transactions desc