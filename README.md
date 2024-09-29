# eks-service
A set of flask apps deployed on EKS, including samples to run using docker, minikube, helm, and terraform. 

# Feature set:
<ul>
  <li>Two flask servers deployed on AWS EKS as services, app & backend</li>
  <li>Configured with metrics-based autoscaling using HorizontalPodAutoScaler</li>
  <li>Deployed as HTTP endpoints using Ingress-backed Application Load Balancer configured with path-based routing on AWS</li>
  <li>Integrated with Prometheus and Grafana stack for k8s for Monitoring and Observability</li>
  <li>Using statically provisioned EBS volume as storage layer for prometheus logs persistence</li>
</ul>
  

# Reference Architecture
![Reference Architecture](https://github.com/abhineet09/eks-service/blob/main/Architecture.png)
