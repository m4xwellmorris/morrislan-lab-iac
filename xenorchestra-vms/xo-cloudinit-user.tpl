#cloud-config
hostname: ${hostname}
user: ops-user
ssh_authorized_keys:
  - OPS_USER_SSH_KEY
manage_etc_hosts: true
fqdn: ${hostname}.${domain}
package_upgrade: true
users:
 - default