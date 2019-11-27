view: utilities {
  sql_table_name: "utilities-smart-air".utilities
    ;;
  drill_fields: [id]
  suggestions: no

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: date {
    type: string
    sql: ${TABLE}."date" ;;
  }

  dimension: hr {
    type: number
    sql: ${TABLE}.hr ;;
  }

  dimension: lat {
    type: number
    sql: ${TABLE}.lat ;;
  }

  dimension: lon {
    type: number
    sql: ${TABLE}.lon ;;
  }

  dimension: location {
    type: location
    sql_latitude: ${TABLE}.lat;;
    sql_longitude: ${TABLE}.lon;;
  }

  dimension: pm10 {
    type: number
    sql: ${TABLE}.pm10 ;;
  }

  dimension: pm25 {
    type: number
    sql: ${TABLE}.pm25 ;;
  }

  dimension: press {
    type: number
    sql: ${TABLE}.press ;;
  }

  dimension: temp {
    type: number
    sql: ${TABLE}.temp ;;
  }

  measure: count {
    type: count
    drill_fields: [id]
  }
}
