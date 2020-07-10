REGISTRY=registry.cn-hangzhou.aliyuncs.com/zero-one
REPOSITORY=wvp-server
CONTAINER=wvp-server
CI_BUILD_TAG=${1:-latest}
PORT=8090
SIP_PORT=5060

git pull origin master
mvn -Dproject.repository=$REPOSITORY -Dproject.tag=$CI_BUILD_TAG package -DskipTests
#docker push ${REGISTRY}/${REPOSITORY}:${CI_BUILD_TAG}
#docker rmi ${REGISTRY}/${REPOSITORY}:${CI_BUILD_TAG}

#git tag ${CI_BUILD_TAG}
#git push origin ${CI_BUILD_TAG}

#docker pull $REGISTRY/$REPOSITORY:$CI_BUILD_TAG
docker rm -f $CONTAINER || true
docker run --name $CONTAINER -m 256m --network host -v /config/wvp:/config -v ~/logs/api/wvp:/logs -d $REPOSITORY:$CI_BUILD_TAG
#docker run --name $CONTAINER -m 256m -v /config/wvp:/config -v ~/logs/api/wvp:/logs -p $PORT:8090 -p $SIP_PORT:5060 -p $SIP_PORT:5060/udp -d $REPOSITORY:$CI_BUILD_TAG