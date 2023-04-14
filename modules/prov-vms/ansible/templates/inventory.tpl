[master_ips]
%{ for master_ip in master_ips ~}
${master_ip}
%{ endfor ~}

[worker_ips]
%{ for worker_ip in worker_ips ~}
${worker_ip}
%{ endfor ~}

