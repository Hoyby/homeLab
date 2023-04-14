- name: apt upgrade
  hosts: '*'
  become: yes
  tasks:
      - name: apt
        apt:
            update_cache: yes
            upgrade: 'yes'

- name: install latest qemu-guest-agent
  hosts: '*'
  tasks:
      - name: install qemu-guest-agent
        apt:
            name: qemu-guest-agent
            state: present
            update_cache: true
        become: true

- name: Set timezone and configure timesyncd
  hosts: '*'
  become: yes
  tasks:
      - name: set timezone
        shell: timedatectl set-timezone Europe/Oslo

      - name: Make sure timesyncd is started
        systemd:
            name: systemd-timesyncd.service
            state: started

- name: ufw-firewall configuration
  hosts: '*'
  become: yes
  tasks:
      - name: install ufw
        apt:
            name: ufw
            state: present
            update_cache: true

      - name: allow ssh
        community.general.ufw:
            rule: allow
            port: ssh
            proto: tcp

      - name: allow outgoing
        community.general.ufw:
            rule: allow
            direction: out
            state: enabled

      - name: deny incoming
        community.general.ufw:
            rule: deny
            direction: in
            state: enabled

      - name: check whether ufw status is active
        shell: ufw status
        changed_when: false
        register: ufw_check

      - debug:
            msg: '{{ ufw_check }}'
