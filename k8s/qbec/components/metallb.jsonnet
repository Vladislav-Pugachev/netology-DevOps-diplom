local p = import '../params.libsonnet';
local params = p.components.metallb;


[
  {
    apiVersion: 'metallb.io/v1beta2',
    kind: 'BGPPeer',
    metadata: {
      name: 'bgp-peer-3',
      namespace: 'metallb-system',
    },
    spec: {
      myASN: params.ASN,
      peerASN: params.ASN,
      peerAddress: params.peerAddress,
      sourceAddress: params.sourceAddress3,
    },
  },
  {
    apiVersion: 'metallb.io/v1beta2',
    kind: 'BGPPeer',
    metadata: {
      name: 'bgp-peer-2',
      namespace: 'metallb-system',
    },
    spec: {
      myASN: params.ASN,
      peerASN: params.ASN,
      peerAddress: params.peerAddress,
      sourceAddress: params.sourceAddress2,
    },
  },
  {
    apiVersion: 'metallb.io/v1beta1',
    kind: 'BGPAdvertisement',
    metadata: {
      name: 'bgp-adver',
      namespace: 'metallb-system',
    },
    spec: {
      ipAddressPools: [
        'lb-address',
      ],
      aggregationLength: 32,
      localPref: 100,
    },
  },
  {
    apiVersion: 'metallb.io/v1beta1',
    kind: 'IPAddressPool',
    metadata: {
      name: 'lb-address',
      namespace: 'metallb-system',
    },
    spec: {
      addresses: [
        params.addresses,
      ],
    },
  },
]