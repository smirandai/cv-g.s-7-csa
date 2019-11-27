view: utilities_route {
#   # Or, you could make this view a derived table, like this:
   derived_table: {
   sql: SELECT * FROM (
SELECT *,
    row_number() over (partition by id order by date DESC) as "row_num_group"
FROM (
SELECT
  A.id  AS "id",
  date_parse(A.date || ' ' || A.time,'%Y/%m/%d %H:%i:%s')  AS "date",
  A.lat as "origin_latitude",
  A.lon as "origin_longitude",
  A.pm10 as "pm10",
  A.pm25 as "pm25",
    B."date" as "date2",
    B.lat as "destination_latitude",
    B.lon as "destination_longitude",
    row_number() over (partition by A.id, B.id, date_parse(A.date || ' ' || A.time,'%Y/%m/%d %H:%i:%s') order by date_parse(A.date || ' ' || A.time,'%Y/%m/%d %H:%i:%s'), B.date) as "row_num"
FROM "utilities-smart-air".utilities AS A
    LEFT JOIN (SELECT
  id  AS "id",
  date_parse(date || ' ' || time,'%Y/%m/%d %H:%i:%s')  AS "date",
  lat,
  lon
FROM "utilities-smart-air".utilities
ORDER BY id,
  "date" ASC) as B
  ON A.id = B.id
  AND date_parse(A.date || ' ' || A.time,'%Y/%m/%d %H:%i:%s') < B.date
ORDER BY A.id,
  A."date" ASC) as preview
WHERE row_num = 1
order by id,
date DESC,
row_num ASC) as final_view
WHERE row_num_group < 20
       ;;
   }

# Define your dimensions and measures here, like this:
   dimension: id {
     description: "Unique ID for each smart air device"
     type: number
     sql: ${TABLE}.id ;;
   }

   dimension: date {
     description: "Timestamp"
     type: date_time
     sql: ${TABLE}.date ;;
   }

    dimension: origin {
      description: "origin"
      type: location
      sql_latitude: ${TABLE}.origin_latitude;;
      sql_longitude:${TABLE}.origin_longitude;;
    }

    dimension: destination {
      description: "destination"
      type: location
      sql_latitude: ${TABLE}.destination_latitude;;
      sql_longitude:${TABLE}.destination_longitude;;
    }
  dimension: pm10 {
    description: "material particulado 10"
    type: number
    sql: ${TABLE}.pm10 ;;
  }
  dimension: pm25 {
    description: "material particulado 25"
    type: number
    sql: ${TABLE}.pm25 ;;
  }
  measure: avg_pm10 {
    type: average
    sql: ${pm10} ;;
    value_format: "#.00;(#.00)"
  }
  measure: avg_pm25 {
    type: average
    sql: ${pm25} ;;
    value_format: "#.00;(#.00)"
  }
  measure: max_pm10 {
    type: max
    sql: ${pm10} ;;
    value_format: "#.00;(#.00)"
  }
  measure: max_pm25 {
    type: max
    sql: ${pm25} ;;
    value_format: "#.00;(#.00)"
  }

#
#   dimension_group: most_recent_purchase {
#     description: "The date when each user last ordered"
#     type: time
#     timeframes: [date, week, month, year]
#     sql: ${TABLE}.most_recent_purchase_at ;;
#   }
#
#   measure: total_lifetime_orders {
#     description: "Use this for counting lifetime orders across many users"
#     type: sum
#     sql: ${lifetime_orders} ;;
#   }
}
