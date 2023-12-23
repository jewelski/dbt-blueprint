with src_colors as (

    select * from {{ ref('seed_colors') }}

),

transformations as (

    select
        id as color_id,
        color_name as color_name,
        hex as hex_code,
        rgb as rgb_code,

        current_timestamp as inserted_at

    from src_colors

)

select

    color_id,
    color_name,
    hex_code,
    rgb_code,
    inserted_at

from transformations
