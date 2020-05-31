docker build -t mephisto2120/multi-client:latest -t mephisto2120/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t mephisto2120/multi-server:latest -t mephisto2120/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t mephisto2120/multi-worker:latest -t mephisto2120/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push mephisto2120/multi-client:latest
docker push mephisto2120/multi-server:latest
docker push mephisto2120/multi-worker:latest

docker push mephisto2120/multi-client:$SHA
docker push mephisto2120/multi-server:$SHA
docker push mephisto2120/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=mephisto2120/multi-server:$SHA
kubectl set image deployments/client-deployment client=mephisto2120/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=mephisto2120/multi-worker:$SHA
