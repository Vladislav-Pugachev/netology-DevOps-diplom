terraform/day_0
cat user-registry.json | docker login   --username json_key   --password-stdin   cr.yandex 
kubectl create secret generic regcred     --from-file=.dockerconfigjson=$HOME/.docker/config.json   --type=kubernetes.io/dockerconfigjson -n kube-system
kubectl create secret -n kube-system generic webapp --from-literal access_key=$(cat user-web.json |  jq '.access_key') --from-literal secret_key=$(cat user-web.json |  jq '.secret_key')
sudo cat /etc/gitlab/initial_root_password
terraform destroy -target=module.vpc -target=module.backend -target=module.web-app -target=module.registry  -auto-approve
terraform apply -target=module.vpc -target=module.ci_cd -target=module.backend -target=module.web-app -target=module.registry -target=module.gitlab -auto-approve

sudo gitlab-rails runner "token = User.find_by_username('root').personal_access_tokens.create(scopes: ['api'], name: 'terraform'); token.set_token('token-string-here123'); token.save!"


k8s
helm install --namespace metallb-system metallb metallb/metallb --create-namespace
helm install --namespace monitoring monitoring monitoring/kube-prometheus-stack --create-namespace

helm install gitlab-runner -f gitlab/values.yml ./gitlab/gitlab-runner-0.51.0.tgz
helm install nginx-ingress nginx-stable/nginx-ingress --set rbac.create=true --namespace ingress-nginx --create-namespace



web-app
git remote add gitlab http://158.160.44.245/gitlab-instance-93491fdd/diplom.git

gre
ssh -i ssh/id_rsa -o ProxyCommand="ssh -i ssh/id_rsa -W %h:%p 158.160.112.233" 10.1.1.253
ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook --key-file ../../ssh/id_rsa --ssh-extra--args='-o ProxyCommand="ssh -i ../../ssh/id_rsa -o StrictHostKeyChecking=no -W %h:%p vlad@51.250.64.167"' -i inventory.yml ./kubespray/cluster.yml -b -v
scp -i ssh/id_rsa 51.250.10.114:client-configs/files/vlad.ovpn vlad.ovpn


ansible-galaxy collection install community.general.modprobe
ansible-galaxy collection install ansible.posix

atlantis plan -p dev
atlantis apply -p dev