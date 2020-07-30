docker build -t dodev123/multi-client:latest -t dodev123/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t dodev123/multi-server:latest -t dodev123/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t dodev123/multi-worker:latest -t dodev123/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push dodev123/multi-client:latest
docker push dodev123/multi-server:latest
docker push dodev123/multi-worker:latest

docker push dodev123/multi-client:$SHA
docker push dodev123/multi-server:$SHA
docker push dodev123/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=dodev123/multi-server:$SHA
kubectl set image deployments/client-deployment client=dodev123/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=dodev123/multi-worker:$SHA

