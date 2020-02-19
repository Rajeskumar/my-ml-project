# Ambassador Project

## Prerequisites:

* Ensure that `Kustomize` is installed.
  * https://github.com/kubernetes-sigs/kustomize
* A running K8s or OpenShift OKD cluster.

## Download Base Manifests
Ambassador CRDS - https://www.getambassador.io/yaml/ambassador/ambassador-crds.yaml
Ambassador Core - https://www.getambassador.io/yaml/ambassador/ambassador-rbac.yaml

Reference : https://www.getambassador.io/user-guide/install-ambassador-oss/

### How to setup on OpenShift/MiniShift
1) Create _ml-serving-sandbox_ namespace and change to namespace

* `oc adm new-project ml-serving-sandbox`
* `oc project ml-serving-sandbox`

2) Apply resources to _ml-serving-sandbox_

* `kustomize build overlays/sandbox/ | oc apply -f -`

3) Create _ml-serving-test_ namespace and change to namespace

* `oc adm new-project ml-serving-test`
* `oc project ml-serving-test`

4) Apply resources to _ml-serving-test_

* `kustomize build overlays/test/ | oc apply -f -`


5) Create _ml-serving-stage_ namespace and change to namespace

* `oc adm new-project ml-serving-stage`
* `oc project ml-serving-stage`

6) Apply resources to _ml-serving-stage_

* `kustomize build overlays/stage | oc apply -f -`

7) Ambassador is exposed at _Route_ created

* `ambassador/ml-serving-<ENVIRONMENT>/<PATH>(if defined)`
  * Get the `route` by: `oc get route`
  * Example: `ambassador-ml-serving-sandbox.192.168.64.10.nip.io`

### Minishift configuration
1) Start OpenShift

* `minishift start`

2) Minishift shell config

* `eval $(minishift oc-env)`

3) Login as admin user

* `oc login -u system:admin`


