
kube:
	git -C kubespray pull || git clone https://github.com/kubernetes-sigs/kubespray.git kubespray
	cp -rfp kubespray/inventory/sample kubespray/inventory/mycluster
	cp ansible.hosts kubespray/inventory/mycluster/hosts.ini
	cp group_vars/all/all.yml kubespray/inventory/mycluster/group_vars/all/all.yml
	cp group_vars/k8s-cluster/k8s-cluster.yml kubespray/inventory/mycluster/group_vars/k8s_cluster/k8s-cluster.yml

kubespray: kube
	export ANSIBLE_TIMEOUT=120; cd kubespray && ansible-playbook -i inventory/mycluster/hosts.ini --become --become-user=root cluster.yml

kubeconf:
	ssh kumori@192.168.1.65 'sudo cat /etc/kubernetes/admin.conf' > ../kubeconf.yaml
	sed -i -e 's/127.0.0.1/192.168.1.65/' ../kubeconf.yaml
	cp ~/.kube/config ~/.kube/config.bak 
	KUBECONFIG=~/.kube/config:../kubeconf.yaml kubectl config view --flatten > /tmp/config
	mv /tmp/config ~/.kube/config
