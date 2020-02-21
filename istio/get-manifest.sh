#!/bin/sh

curl -L https://istio.io/downloadIstio | ISTIO_VERSION=1.4.2 sh -

./istio-1.4.2/bin/istioctl manifest generate > manifest/istio-manifest.yaml
