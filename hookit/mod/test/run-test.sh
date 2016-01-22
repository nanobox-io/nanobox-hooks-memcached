# Test memcached after build
set -e
docker run --name=memcached-test -d nanobox/memcached
docker exec -it memcached-test /bin/bash
curl localhost:5540/hooks/configure -d '{"logtap_host":"10.0.2.15:6361","uid":"cache1"}'
sleep 2
sv status cache
exit
docker kill memcached-test
docker rm memcached-test
