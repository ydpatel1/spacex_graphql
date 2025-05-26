class LaunchQueries {
  static const String getLaunches = '''
    query LaunchesPast(
      \$find: LaunchFind,
      \$limit: Int, 
      \$offset: Int, 
      \$order: String, 
      \$sort: String
    ) {
      launchesPast(
        find: \$find,
        limit: \$limit, 
        offset: \$offset, 
        order: \$order, 
        sort: \$sort
      ) {
        details
        id
        is_tentative
        launch_date_local
        launch_date_unix
        launch_date_utc
        launch_site {
          site_id
          site_name
          site_name_long
        }
        launch_success
        launch_year
        links {
          article_link
          flickr_images
          mission_patch
          mission_patch_small
          presskit
          reddit_campaign
          reddit_launch
          reddit_media
          reddit_recovery
          video_link
          wikipedia
        }
        mission_id
        mission_name
        rocket {
          fairings {
            recovered
            recovery_attempt
            reused
            ship
          }
          first_stage {
            cores {
              block
              core {
                asds_attempts
                asds_landings
                block
                id
                missions {
                  flight
                  name
                }
                original_launch
                reuse_count
                rtls_attempts
                rtls_landings
                status
                water_landing
              }
              flight
              gridfins
              land_success
              landing_intent
              landing_type
              landing_vehicle
              legs
              reused
            }
          }
          rocket_name
          rocket_type
        }
        static_fire_date_unix
        static_fire_date_utc
        telemetry {
          flight_club
        }
        tentative_max_precision
        upcoming
      }
    }
  ''';

  static const String getLaunchById = '''
    query GetLaunchById(\$id: ID!) {
      launch(id: \$id) {
        details
        id
        is_tentative
        launch_date_local
        launch_date_unix
        launch_date_utc
        launch_site {
          site_id
          site_name
          site_name_long
        }
        launch_success
        launch_year
        links {
          article_link
          flickr_images
          mission_patch
          mission_patch_small
          presskit
          reddit_campaign
          reddit_launch
          reddit_media
          reddit_recovery
          video_link
          wikipedia
        }
        mission_id
        mission_name
        rocket {
          fairings {
            recovered
            recovery_attempt
            reused
            ship
          }
          first_stage {
            cores {
              block
              core {
                asds_attempts
                asds_landings
                block
                id
                missions {
                  flight
                  name
                }
                original_launch
                reuse_count
                rtls_attempts
                rtls_landings
                status
                water_landing
              }
              flight
              gridfins
              land_success
              landing_intent
              landing_type
              landing_vehicle
              legs
              reused
            }
          }
          rocket_name
          rocket_type
        }
        static_fire_date_unix
        static_fire_date_utc
        telemetry {
          flight_club
        }
        tentative_max_precision
        upcoming
      }
    }
  ''';

  static const String getRockets = '''
    query Rockets(\$limit: Int, \$offset: Int) {
      rockets(limit: \$limit, offset: \$offset) {
        id
        name
        type
        description
        active
        boosters
        company
        cost_per_launch
        country
        diameter {
          feet
          meters
        }
        engines {
          engine_loss_max
          layout
          number
          propellant_1
          propellant_2
          thrust_sea_level {
            kN
            lbf
          }
          thrust_to_weight
          thrust_vacuum {
            kN
            lbf
          }
          type
          version
        }
        first_flight
        first_stage {
          burn_time_sec
          engines
          fuel_amount_tons
          reusable
        }
        height {
          feet
          meters
        }
        landing_legs {
          material
          number
        }
        mass {
          kg
          lb
        }
        payload_weights {
          id
          kg
          lb
          name
        }
        second_stage {
          burn_time_sec
          engines
          fuel_amount_tons
          thrust {
            kN
            lbf
          }
        }
        stages
        success_rate_pct
        wikipedia
      }
    }
  ''';
}
