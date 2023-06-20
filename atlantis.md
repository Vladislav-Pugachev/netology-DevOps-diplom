158.160.47.77
atlantis server --atlantis-url=http://158.160.47.77 --gitlab-user=root --gitlab-token=w9W0CZACjjZiEjwB9n5lIBL23lbavqILG9mDw3t26Hc= --repo-allowlist=158.160.47.77/*

atlantis server --atlantis-url=http://10.0.0.4 --gitlab-user=root --gitlab-token=glpat-EDPmFjTipGYDDjR56u4_ --repo-allowlist=10.0.0.4/* --gitlab-hostname=http://10.0.0.4


[Unit]
Description=Atlantis

[Service]
Type=simple
ExecStart=/usr/bin/atlantis server --atlantis-url=http://10.0.0.4 --gitlab-user=root --gitlab-token=glpat-EDPmFjTipGYDDjR56u4_ --repo-allowlist=10.0.0.4/* --gitlab-hostname=http://10.0.0.4

[Install]
WantedBy=multi-user.target



/home/vlad/repos.yaml

repos:
- id: /.*/

  # With just allowed_overrides: [workflow], repos can only
  # choose workflows defined server-side.
  allowed_overrides: [workflow]

  # By setting allow_custom_workflows to true, we allow repos to also
  # define their own workflows.
  allow_custom_workflows: true
~                                 