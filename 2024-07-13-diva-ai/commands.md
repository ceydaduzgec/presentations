# Minikube

brew install minikube
minikube start


# kubectl-ai

brew tap sozercan/kubectl-ai https://github.com/sozercan/kubectl-ai
brew install kubectl-ai

export OPENAI_API_KEY=
export OPENAI_DEPLOYMENT_NAME="gpt-3.5-turbo"


kubectl ai "Create a namespace called ns1 and create a Nginx Pod"
kubectl port-forward nginx-pod 8000:80 -n ns1 

kubectl ai "create an redis pod with image redis123"

--require-confirmation=false

# Kubeview:

git clone https://github.com/benc-uk/kubeview
cd kubeview/charts/
helm install kubeview kubeview

sudo kubectl port-forward svc/kubeview 80:80


# K8sGPT:

brew tap k8sgpt-ai/k8sgpt
brew install k8sgpt
k8sgpt generate -> https://platform.openai.com/api-keys
k8sgpt auth (add list)

k8sgpt analyze
k8sgpt analyze --explain

k8sgpt filters list
k8sgpt filters add [filter]
k8sgpt filters add Service,Pod
k8sgpt filters remove [filter]
k8sgpt filters remove Service

k8sgpt analyze --filter=Pod --namespace=default --label-selector=app=myapp 

--anonymize


# Local AI


# Delete minikube 

minikube stop; minikube delete &&
docker stop $(docker ps -aq) &&
rm -rf ~/.kube ~/.minikube &&
sudo rm -rf /usr/local/bin/localkube /usr/local/bin/minikube &&
launchctl stop '*kubelet*.mount' &&
launchctl stop localkube.service &&
launchctl disable localkube.service &&
sudo rm -rf /etc/kubernetes/ &&
docker system prune -af --volumes



https://platform.openai.com/docs/guides/error-codes/api-errors