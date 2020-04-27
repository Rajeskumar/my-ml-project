# Seldon Project

## Prerequisites:

* Ensure that `Kustomize` and `helm3` is installed.
  * https://github.com/kubernetes-sigs/kustomize
* A running K8s or OpenShift OKD cluster.

### Helm command to download the base template
`helm template seldon-core seldon-core-operator --version 1.0.0 --repo https://storage.googleapis.com/seldon-charts --set singleNamespace=true --set image.pullPolicy=IfNotPresent --set crd.create=true --set webhook.port=8443 --namespace=ml-serving > base/bby-seldon-core.yaml`

### How to setup on OpenShift/MiniShift
1) Create _ml-serving-sandbox_ namespace and change to namespace

* `oc adm new-project ml-serving-sandbox`
* `oc project ml-serving-sandbox`

2) Apply resources to _ml-serving-sandbox_

* `kustomize build overlays/sandbox | oc apply -f -`

3) Create _ml-serving-test_ namespace and change to namespace

* `oc adm new-project ml-serving-test`
* `oc project ml-serving-test`

4) Apply resources to _ml-serving-test_

* `kustomize build overlays/test | oc apply -f -`


5) Create _ml-serving-stage_ namespace and change to namespace

* `oc adm new-project ml-serving-stage`
* `oc project ml-serving-stage`

6) Apply resources to _ml-serving-stage_

* `kustomize build overlays/stage | oc apply -f -`

7) Apply example _SeldonDeployment_ manifest in an _ml-serving-($environment)_ namespace for the Seldon-Core-Operator to handle.

* `oc apply -f example/example-manifest.json`

18) Deployment is exposed at _Route_ created

* `<ROUTE>/seldon/ml-serving-<ENVIRONMENT>/<MODEL_NAME>/api/v0.1/predictions`
  * Get the `route` by: `oc get route` and copy+paste the "HOST/PORT" into the <ROUTE> section
  * Get the `environment` based on the current namespace you are in: `oc get project`
  * Get the `model name` by looking at the name of the `SeldonDeployment`, short name `sdep`: `oc get sdep`
  * Example: `ambassador-ml-serving-sandbox.192.168.99.152.nip.io/seldon/ml-serving-sandbox/mnistcombo/api/v0.1/predictions`

* The RESTful interface accepts `POST` requests.
  * A `GET` will give you the following:
      *  Request: `$curl http://ambassador-ml-serving-sandbox.192.168.99.152.nip.io/seldon/ml-serving-sandbox/mnistcombo/api/v0.1/predictions`
      *  Response: `{"timestamp":1570118874865,"status":405,"error":"Method Not Allowed","exception":"org.springframework.web.HttpRequestMethodNotSupportedException","message":"Request method 'GET' not supported","path":"/api/v0.1/predictions"}`
  * A `POST` looks like this:
    * `$curl -H "Content-Type: application/json" -X POST http://ambassador-ml-serving-sandbox.192.168.99.152.nip.io/seldon/ml-serving-sandbox/mnistcombo/api/v0.1/predictions -d "[[-0.886 -1.141 -0.62]]`"
    * Note this will give back an error at the moment. 
    * TODO - Figure out actual request for `mock_classifier`


---

### Minikube configuration
1) Start K8s

* `minikube start --cpus 4 --memory 4096`

2) Setup shell configuration

* `eval $(minikube docker-env)`

3) Enable ingress on Minikube

* `minikube addons enable ingress`


### Minishift configuration
1) Start OpenShift

* `minishift start`

2) Minishift shell config

* `eval $(minishift oc-env)`

3) Login as admin user

* `oc login -u system:admin`

4) Ensure that both Mutating and Validation Admission Webhooks are enabled

* `minishift addons install --defaults`
* `minishift addons apply admissions-webhook`

