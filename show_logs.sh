for d in {repository,logic,s1}
do
    echo "LOGS for $d"
    docker logs $d
    echo ""
    echo ""
done

