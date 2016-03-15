# source docker helpers
. util/docker.sh

echo_lines() {
  for (( i=0; i < ${#lines[*]}; i++ ))
  do
    echo ${lines[$i]}
  done
}

@test "Start Container" {
  start_container "simple-single" "192.168.0.2"
}

@test "simple-single-plan" {
  run run_hook "simple-single" "plan" "$(payload plan)"
  echo_lines
  [ "$status" -eq 0 ]

  [ "${lines[0]}" = "{" ]
  [ "${lines[1]}" = "  \"redundant\": false," ]
  [ "${lines[2]}" = "  \"horizontal\": false," ]
  [ "${lines[3]}" = "  \"users\": [" ]
  [ "${lines[4]}" = "  ]," ]
  [ "${lines[5]}" = "  \"ips\": [" ]
  [ "${lines[6]}" = "    \"default\"" ]
  [ "${lines[7]}" = "  ]," ]
  [ "${lines[8]}" = "  \"port\": 11211," ]
  [ "${lines[9]}" = "  \"behaviors\": [" ]
  [ "${lines[10]}" = "    \"migratable\"" ]
  [ "${lines[11]}" = "  ]" ]
  [ "${lines[12]}" = "}" ]
}

@test "Stop Container" {
  stop_container "simple-single"
}