# Install metrics server to enable HorizontalPodAutoscaling
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml

kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml

kubectl get deployment metrics-server -n kube-system

# Installing a helm chart
helm upgrade --install app helm/service -f $WORK_DIR/helm/service/app_values.yaml

helm upgrade --install backend helm/service -f $WORK_DIR/helm/service/backend_values.yaml