local p = import '../params.libsonnet';
local params = p.components.monitoring;

[
  {
    apiVersion: 'v1',
    kind: 'Service',
    metadata: {
      annotations: {
        'meta.helm.sh/release-name': 'monitoring',
        'meta.helm.sh/release-namespace': 'monitoring',
      },
      labels: {
        'app.kubernetes.io/instance': 'monitoring',
        'app.kubernetes.io/managed-by': 'Helm',
        'app.kubernetes.io/name': 'grafana',
        'app.kubernetes.io/version': '9.3.8',
        'helm.sh/chart': 'grafana-6.51.5',
      },
      name: 'monitoring-grafana',
      namespace: 'monitoring',
    },
    spec: {
      type: 'LoadBalancer',
      loadBalancerIP: params.loadBalancerIP,
      externalTrafficPolicy: 'Cluster',
      ipFamilies: [
        'IPv4',
      ],
      ipFamilyPolicy: 'SingleStack',
      ports: [
        {
          name: 'http-web',
          port: 80,
          protocol: 'TCP',
          targetPort: 3000,
        },
      ],
      selector: {
        'app.kubernetes.io/instance': 'monitoring',
        'app.kubernetes.io/name': 'grafana',
      },
      sessionAffinity: 'None',
    },
  },
]