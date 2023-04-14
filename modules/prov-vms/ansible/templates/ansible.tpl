[defaults]
inventory = ./inventory
remote_user = ${ciuser}
host_key_checking = False
pretty_results = True
remote_tmp = /tmp/ansible
display_ok_hosts = yes
private_key_file = ${private_key_file}

[ssh_connection]
ssh_args = -o ServerAliveInterval=200