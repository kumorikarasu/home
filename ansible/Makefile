all: requirements jumpbox bind llvm plex nexus

bind:
	ansible-playbook bind.yml -i ansible.hosts

llvm:
	ansible-playbook llvm.yml -i ansible.hosts

jumpbox:
	ansible-playbook jumpbox.yml -i ansible.hosts

plex:
	ansible-playbook plex.yml -i ansible.hosts
	
nexus: requirements
	ansible-playbook nexus.yml -i ansible.hosts

requirements:
	ansible-galaxy install -r requirements.yml

kube:
	git -C kubespray pull || git clone https://github.com/kubernetes-sigs/kubespray.git kubespray
	##cd kubespray && git checkout release-2.22
	##pip3 install -r kubespray/requirements.txt
	##cd kubespray && cp -rfp inventory/sample inventory/mycluster
	##cd kubespray && CONFIG_FILE=inventory/mycluster/hosts.yaml python3 contrib/inventory_builder/inventory.py 192.168.1.50
	cp -rfp kubespray/inventory/sample kubespray/inventory/mycluster
	cp ansible.hosts kubespray/inventory/mycluster/hosts.ini
	cp group_vars/all/all.yml kubespray/inventory/mycluster/group_vars/all/all.yml
	cp group_vars/k8s-cluster/k8s-cluster.yml kubespray/inventory/mycluster/group_vars/k8s_cluster/k8s-cluster.yml

kubespray: kube
  #export ANSIBLE_TIMEOUT=120; cd kubespray && ansible-playbook -i inventory/mycluster/hosts.yaml  --become --become-user=root cluster.yml
	ansible-playbook kube.yml -i ansible.hosts
	export ANSIBLE_TIMEOUT=120; cd kubespray && ansible-playbook -i inventory/mycluster/hosts.ini --become --become-user=root cluster.yml

kubeconf:
	ssh kumori@192.168.1.50 'sudo cat /etc/kubernetes/admin.conf' > ../kubeconf.yaml
	sed -i -e 's/127.0.0.1/192.168.1.50/' ../kubeconf.yaml
	cp ~/.kube/config ~/.kube/config.bak 
	KUBECONFIG=~/.kube/config:../kubeconf.yaml kubectl config view --flatten > /tmp/config
	mv /tmp/config ~/.kube/config
