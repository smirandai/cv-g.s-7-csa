view: utilities_last_data {
# Or, you could make this view a derived table, like this:
derived_table: {
sql: SELECT
  A.id  AS "id",
  date(date_parse(A.date || ' ' || A.time,'%Y/%m/%d %H:%i:%s')) AS "date",
  hour(date_parse(A.date || ' ' || A.time,'%Y/%m/%d %H:%i:%s')) AS "hour",
  AVG(temp) as temp,
  AVG(press) as press,
  AVG(hr) as hr,
  AVG(pm10) as pm10,
  AVG(pm25) as pm25
FROM "utilities-smart-air".utilities AS A
WHERE CURRENT_TIMESTAMP - interval '5' hour < date_parse(A.date || ' ' || A.time,'%Y/%m/%d %H:%i:%s')
GROUP BY A.id,
  date_parse(A.date || ' ' || A.time,'%Y/%m/%d %H:%i:%s'),
  date_parse(A.date || ' ' || A.time,'%Y/%m/%d %H:%i:%s')
ORDER BY id,
  date,
  hour
       ;;
   }

# Define your dimensions and measures here, like this:
  dimension: id {
    description: "Unique ID for each smart air device"
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: date {
    description: "date"
    type: string
    sql: ${TABLE}.date ;;
  }

  dimension: hour {
    description: "hour"
    type: number
    sql: ${TABLE}.hour ;;
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
  dimension: hr {
    description: "HR"
    type: number
    sql: ${TABLE}.hr ;;
  }
  dimension: press {
    description: "presion"
    type: number
    sql: ${TABLE}.press ;;
  }
  dimension: temp {
    description: "temperatura"
    type: number
    sql: ${TABLE}.temp ;;
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
  measure: avg_hr {
    type: average
    sql: ${hr} ;;
    value_format: "#.00;(#.00)"
  }
  measure: max_hr {
    type: max
    sql: ${hr} ;;
    value_format: "#.00;(#.00)"
  }
  measure: avg_press {
    type: average
    sql: ${press} ;;
    value_format: "#.00;(#.00)"
  }
  measure: max_press {
    type: max
    sql: ${press} ;;
    value_format: "#.00;(#.00)"
  }
  measure: avg_temp {
    type: average
    sql: ${temp} ;;
    value_format: "#.00;(#.00)"
  }
  measure: max_temp {
    type: max
    sql: ${temp} ;;
    value_format: "#.00;(#.00)"
  }
}
