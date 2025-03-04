#Configuração do cluster GKE

aws eks update-kubeconfig --region us-east-1 --name eks-cluster-dev --alias devopslabs --profile dev

# Install nginx ingress controller
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.12.0-beta.0/deploy/static/provider/cloud/deploy.yaml

#Instalação da aplicação

kubectl apply -f ./config/namespace.yaml
kubectl apply -f ./config/
kubectl apply -f ./deploys/

