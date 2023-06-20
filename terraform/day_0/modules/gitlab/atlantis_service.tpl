[Unit]
Description=Atlantis

[Service]
Type=simple
ExecStart=/usr/bin/atlantis server --atlantis-url=http://${url} --gitlab-user=root --gitlab-token=${gitlab_atlantis_api_token} --repo-allowlist=${url}/* --gitlab-hostname=http://${url} --repo-config=/home/vlad/repos.yaml

[Install]
WantedBy=multi-user.target

