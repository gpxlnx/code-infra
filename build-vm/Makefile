conn-test:
	ansible -i inventory/hosts.ini all -U root -K -m ping

build-vm:
	ansible-playbook -i inventory/hosts.ini site.yml -u root -k -e ansible_ssh_user=root

update-vm:
	ansible-playbook -i inventory/hosts.ini site.yml -u ansible -b -e ansible_ssh_user=ansible