# helm-jitsi

repository contains helm charts for running a jitsi server on kuberentes

## deploy on local microk8s

``` 
helm upgrade --install --cleanup-on-fail --values .\values-microk8s.yml jitsi . 
```
