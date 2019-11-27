connection: "smart-air-raw-database-entelocean"

# include all the views
include: "/views/**/*.view"

datagroup: smart_air_entelocean_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: smart_air_entelocean_default_datagroup

explore: utilities {}
explore: utilities_route {}
explore: utilities_last_data {}
