For Bootstrap helm charts:

aws load-balancer controller:
```
helm repo add eks https://aws.github.io/eks-charts
helm upgrade -i aws-load-balancer-controller eks/aws-load-balancer-controller --version 1.10.0 -f ./bootstrap/aws-lb-controller/values.yaml -n kube-system 
```

public external dns:
```
helm repo add external-dns https://kubernetes-sigs.github.io/external-dns/
helm upgrade -i external-dns external-dns/external-dns --version 1.15.0 -f ./bootstrap/public-external-dns/values.yaml -n kube-system
```

cluster-autoscaler:
```
helm repo add autoscaler https://kubernetes.github.io/autoscaler
helm upgrade -i cluster-autoscaler autoscaler/cluster-autoscaler --version 9.43.2 -f ./bootstrap/cluster-autoscaler/values.yaml -n kube-system
```

For Candidates chart:

```
helm upgrade -i dev ./candidates -f ./candidates/values.yaml -n dev --create-namespace
```

The candidates app is exposed on: 

[dev-barkuni-candidates](http://dev-barkuni-candidates-846977533.us-east-1.elb.amazonaws.com/)

For debug purposes you can expose the app with port-forward command:
```
kubectl port-forward service/<service-name> <local-port>:<service-port> -n <namespace>

for example:
kubectl port-forward service/dev-candidates 5000:80 -n dev
```