test-conn:
	@ansible -i inventory/hosts.ini all -u root -k -m ping

install-ssh:
	@ansible-playbook -i inventory/hosts.ini ssh.yml -u root -k -e ansible_ssh_user=root

build-vm:
	@ansible-playbook -i inventory/hosts.ini build.yml -u ansible -b -e ansible_ssh_user=ansible