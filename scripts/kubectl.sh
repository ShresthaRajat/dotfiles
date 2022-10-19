# get details about cluster
kubectl version
kubectl cluster-info
kubectl get pods -o=custom-columns=NAME:.metadata.name,STATUS:.status.phase,NODE:.spec.nodeName --all-namespaces
kubectl get pods --no-headers -o custom-columns=":metadata.name"
kubectl get pods -o=name
kubectl get pods --template '{{range .items}}{{.metadata.name}}{{"\n"}}{{end}}'\
kubectl get pods
kubectl get rs
kubectl get clusterroles.rbac.authorization.k8s.io --all-namespaces
kubectl get roles.rbac.authorization.k8s.io --all-namespaces
kubectl get deployments --namespace kube-system
kubectl get all
kubectl get secrets
kubectl get podtemplates
kubectl get configmaps
kubectl get componentstatuses
kubectl get endpoints
kubectl get ingress,po, svc

# view and manage kubectl config
kubectl config view
kubectl config unset cluster
kubectl config unset context
kubectl config unset user
kubectl config set-context --current --namespace=hello-world

# logs
kubectl logs webserver
kubectl logs deploy/my-deployment
kubectl logs test-nginx

# namespaces
kubectl delete namespace azure-vote
kubectl create namespace nginx-test

#MSIC
kubectl -v=4 config
kubectl run tengix --image 
kubectl describe webserver

# add/edit secrets
kubectl edit secrets somethingSecret
kubectl add secrets somethingSecret

# use kubectl from minikube
minikube kubectl
minikube kubectl -- get pods -A

# kubectl create/apply deployments, svc, ingress
kubectl create -f hw1.yml
kubectl create -f hw2.yml
kubectl create deployment hello-minikube1 --image=k8s.gcr.io/echoserver:1.4\
kubectl apply -f pods01.yaml
kubectl apply -f nginx-test.yml --insecure-skip-tls-verify --namespace automated-deployments-shrestharajat
kubectl apply -f nginx-test.yml --namespace automated-deployments-shrestharajat

# expose pods/deployments
kubectl expose pod webserver --type=LoadBalancer --port=80 --name=webs
kubectl expose pod webserver --type=LoadBalancer --port=80 --target-port=80
kubectl expose deployment hello-minikube1 --type=NodePort --port=8080
kubectl expose deployment test-nginx-646fb4f75c-6gvr6 --type=LoadBalancer --port=8080
kubectl expose deployment test-nginx --type=LoadBalancer --port=8080


# delete pod/deployments syntax
kubectl delete pod unwanted --now
kubectl delete pod webserver
kubectl delete deploy testingnginx42069
kubectl delete deployments testingnginx42069
kubectl delete -f azure-vote.yml
kubectl delete -f nginx-test.yml --namespace automated-deployments-shrestharajat