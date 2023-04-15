- name: reboot all servers
  hosts: '*'
  become: yes
  tasks:
      - name: reboot
        ansible.builtin.reboot: