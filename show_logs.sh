for d in {repository,logic,rest}
do
    echo "LOGS for $d"
    docker logs $d
    echo ""
    echo ""
done

