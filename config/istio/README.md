-- WIP --
Istio - Service Mesh
Local setup
Start GitOps Operator

Synchronize state of cluster for Istio.

Verify Istio Installation
Determine Ingress IP and Port & Setup Environment variables
$ kubectl get svc istio-ingressgateway -n istio-system

$ export INGRESS_PORT=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="http2")].nodePort}') $ export SECURE_INGRESS_PORT=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="https")].nodePort}')

For Minikube
$ export INGRESS_HOST=$(minikube ip)

Set GATEWAY_URL Environment variable
$ export GATEWAY_URL=$INGRESS_HOST:$INGRESS_PORT

Upgrading Istio
$ istioctl x upgrade -f <your-istiocontrolplane-config-changes>

Production
$ istioctl manifest apply values.global.mtls.enabled=true --set values.global.controlPlaneSecurityEnabled=true --set telemetry.enabled=true
