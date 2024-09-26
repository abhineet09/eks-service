# Installing a helm chart
helm upgrade --install app helm/service -f $WORK_DIR/helm/service/app_values.yaml

helm upgrade --install backend helm/service -f $WORK_DIR/helm/service/backend_values.yaml