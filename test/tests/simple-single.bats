# source docker helpers
. util/docker.sh

echo_lines() {
  for (( i=0; i < ${#lines[*]}; i++ ))
  do
    echo ${lines[$i]}
  done
}

@test "Start Local Container" {
  start_container "simple-single-local" "192.168.0.2"
}

@test "Configure Local Container" {
  run run_hook "simple-single-local" "configure" "$(payload default/configure-local)"
  echo_lines
  [ "$status" -eq 0 ] 
}

@test "Start Local Memcached" {
  run run_hook "simple-single-local" "start" "$(payload default/start)"
  echo_lines
  [ "$status" -eq 0 ]
  # Verify
  run docker exec simple-single-local bash -c "ps aux | grep [m]emcached"
  echo_lines
  [ "$status" -eq 0 ]
  until docker exec "simple-single-local" bash -c "nc 192.168.0.2 11211 < /dev/null"
  do
    sleep 1
  done
}

@test "Insert Local Memcached Data" {
  run docker exec simple-single-local bash -c "printf 'set mykey 0 60 4\r\ndata\r\n' | nc 192.168.0.2 11211"
  run docker exec simple-single-local bash -c "printf 'get mykey\r\n' | nc 192.168.0.2 11211"
  echo_lines
  data=$(echo -e "data\r")
  [ "${lines[1]}" = "${data}" ]
  [ "$status" -eq 0 ]
}

@test "Stop Local Memcached" {
  run run_hook "simple-single-local" "stop" "$(payload default/stop)"
  echo_lines
  [ "$status" -eq 0 ]
  while docker exec "simple-single-local" bash -c "ps aux | grep [m]emcached"
  do
    sleep 1
  done
  # Verify
  run docker exec simple-single-local bash -c "ps aux | grep [m]emcached"
  echo_lines
  [ "$status" -eq 1 ] 
}

@test "Stop Local Container" {
  stop_container "simple-single-local"
}

@test "Start Production Container" {
  start_container "simple-single-production" "192.168.0.2"
}

@test "Configure Production Container" {
  run run_hook "simple-single-production" "configure" "$(payload default/configure-production)"
  echo_lines
  [ "$status" -eq 0 ] 
}

@test "Start Production Memcached" {
  run run_hook "simple-single-production" "start" "$(payload default/start)"
  echo_lines
  [ "$status" -eq 0 ]
  # Verify
  run docker exec simple-single-production bash -c "ps aux | grep [m]emcached"
  echo_lines
  [ "$status" -eq 0 ]
  until docker exec "simple-single-production" bash -c "nc 192.168.0.2 11211 < /dev/null"
  do
    sleep 1
  done
}

@test "Insert Production Memcached Data" {
  run docker exec simple-single-production bash -c "printf 'set mykey 0 60 4\r\ndata\r\n' | nc 192.168.0.2 11211"
  run docker exec simple-single-production bash -c "printf 'get mykey\r\n' | nc 192.168.0.2 11211"
  echo_lines
  data=$(echo -e "data\r")
  [ "${lines[1]}" = "${data}" ]
  [ "$status" -eq 0 ]
}

@test "Stop Production Memcached" {
  run run_hook "simple-single-production" "stop" "$(payload default/stop)"
  echo_lines
  [ "$status" -eq 0 ]
  while docker exec "simple-single-production" bash -c "ps aux | grep [m]emcached"
  do
    sleep 1
  done
  # Verify
  run docker exec simple-single-production bash -c "ps aux | grep [m]emcached"
  echo_lines
  [ "$status" -eq 1 ] 
}

@test "Stop Production Container" {
  stop_container "simple-single-production"
}