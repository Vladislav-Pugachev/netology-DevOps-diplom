
{
  components: {
    metallb: {
      ASN: 65001,
      peerAddress: '10.1.0.254',
      addresses: '172.16.1.0/24',
      sourceAddress2: '10.1.2.254',
      sourceAddress3: '10.1.3.254',
    },
    monitoring: {
      loadBalancerIP: '172.16.1.1',
    },  
  },
}