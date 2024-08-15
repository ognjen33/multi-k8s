docker build -t ognjen33/multi-client:latest -t ognjen33/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t ognjen33/multi-server:latest -t ognjen33/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t ognjen33/multi-worker:latest -t ognjen33/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push ognjen33/multi-client:latest
docker push ognjen33/multi-server:latest
docker push ognjen33/multi-worker:latest

docker push ognjen33/multi-client:$SHA
docker push ognjen33/multi-server:$SHA
docker push ognjen33/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=ognjen33/multi-server:$SHA
kubectl set image deployments/client-deployment client=ognjen33/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=ognjen33/multi-worker:$SHA
