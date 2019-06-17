conn-test:
	ansible -i inventory/hosts.ini all -u root -k -m ping

build-vm:
	ansible-playbook -i inventory/hosts.ini site.yml -u root -k

update-vm:
	ansible-playbook -i inventory/hosts.ini site.yml