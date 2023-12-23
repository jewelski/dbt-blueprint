with colors as (

    select * from {{ ref('stg_colors') }}

),

transformations as (

    select

        color_id,
        color_name,
        hex_code,
        rgb_code,

        current_timestamp as inserted_at

    from colors

)

select

    color_id,
    color_name,
    hex_code,
    rgb_code,
    inserted_at

from transformations
