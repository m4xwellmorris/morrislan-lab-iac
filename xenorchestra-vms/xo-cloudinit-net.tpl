#cloud-config
version: 1
config:
    - type: physical
      name: eth0
      subnets:
      - type: static
        address: '${ip}'
        netmask: '255.255.255.0'
        gateway: '10.1.50.1'