For Bootstrap helm charts:

aws load-balancer controller:
```
helm repo add eks https://aws.github.io/eks-charts
helm upgrade -i aws-load-balancer-controller eks/aws-load-balancer-controller --version 1.10.0 -f ./aws-lb-controller/values.yaml -n kube-system 
```

public external dns:
```
helm repo add external-dns https://kubernetes-sigs.github.io/external-dns/
helm upgrade -i external-dns external-dns/external-dns --version 1.15.0 -f ./public-external-dns/values.yaml -n kube-system
```

cluster-autoscaler:
```
helm repo add autoscaler https://kubernetes.github.io/autoscaler
helm upgrade -i cluster-autoscaler autoscaler/cluster-autoscaler --version 9.43.2 -f ./cluster-autoscaler/values.yaml -n kube-system
```

For Candidates chart:

