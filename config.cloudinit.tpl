#cloud-config
hostname: ${name}
user: local
ssh_authorized_keys:
  - ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHUFJ0c3pOHMB9f0f/ugKKLH+AsWDsciT4xAheiCfFrI setup-key
manage_etc_hosts: true
fqdn: ${name}.morris.lan
package_upgrade: true
users:
 - default