# ignress-nginx-log4shell-plugin
LUA plugin to mitigate log4shell vulnerability for ingress-nginx

See https://github.com/kubernetes/ingress-nginx/tree/main/rootfs/etc/nginx/lua/plugins for details on using plugins with ingress-nginx.

# Example installation
Create configmap in Kubernetes in the same namespace as ingress-nginx:

`kubectl -n infra create configmap log4shell --from-file=main.lua`

Mount the configmap into your ingress-nginx helm chart by specifying it in your values:

https://github.com/kubernetes/ingress-nginx/blob/main/charts/ingress-nginx/values.yaml#L548

i.e. 

```extraVolumeMounts: []
  ## Additional volumeMounts to the controller main container.
    - name: log4shell
      mountPath: "/etc/nginx/lua/plugins/log4shell"

  extraVolumes: []
  ## Additional volumes to the controller pod.
    - name: log4shell
      configMap: 
        - name: log4shell
```

and activate the plugin:

```
config:
...
plugins: "log4shell"
```

You should see all incoming requests be denied with a 403 error.
