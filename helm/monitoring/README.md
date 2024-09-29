# Steps to setup statically provisioned EBS Volume (gp2) as Prometheus Server storage

# Make EBS volume ready for use - Setup only!
https://docs.aws.amazon.com/ebs/latest/userguide/ebs-using-volumes.html

sudo file -s /dev/xvdf

sudo mkfs -t xfs /dev/xvdf

# Install CSI Driver in EKS Cluster
eksctl create iamserviceaccount \
        --name ebs-csi-controller-sa \
        --namespace kube-system \
        --cluster $CLUSTER_NAME \
        --role-name AmazonEKS_EBS_CSI_DriverRole \
        --role-only \
        --attach-policy-arn arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy \
        --approve

# export arn of the created role (AmazonEKS_EBS_CSI_DriverRole) as $EBS_CSI_DriverRole_ARN

eksctl create addon --cluster $CLUSTER_NAME --name aws-ebs-csi-driver --version v1.35.0-eksbuild.1 \
    --service-account-role-arn $EBS_CSI_DriverRole_ARN --force

# Setting up storage layer for Prometheus

# export $EBS_VOLUME_ID

helm upgrade --install storage helm/monitoring/storage --set volumeID=$EBS_VOLUME_ID

# Installing Prometheus stack with Grafana
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo updatek get pvc


helm upgrade --install kube-prometheus prometheus-community/kube-prometheus-stack -f helm/monitoring/kube-prometheus-stack/values.yaml

kubectl get pods -l "release=kube-prometheus"

# Access Prometheus/Grafana locally using Port-forwarding
kubectl port-forward svc/kube-prometheus-kube-prome-prometheus 9090:9090

kubectl port-forward svc/kube-prometheus-grafana 8080:80

# To get the Grafana Password
kubectl get secret kube-prometheus-grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo