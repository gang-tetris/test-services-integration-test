for d in {repository,logic,rest,cassandra,hazelcast,rabbit}
do
    echo "LOGS for $d"
    docker logs $d
    echo ""
    echo ""
done

