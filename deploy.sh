docker build -t ognjen3/multi-client:latest -t ognjen3/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t ognjen3/multi-server:latest -t ognjen3/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t ognjen3/multi-worker:latest -t ognjen3/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push ognjen3/multi-client:latest
docker push ognjen3/multi-server:latest
docker push ognjen3/multi-worker:latest

docker push ognjen3/multi-client:$SHA
docker push ognjen3/multi-server:$SHA
docker push ognjen3/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=ognjen3/multi-server:$SHA
kubectl set image deployments/client-deployment client=ognjen3/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=ognjen3/multi-worker:$SHA
