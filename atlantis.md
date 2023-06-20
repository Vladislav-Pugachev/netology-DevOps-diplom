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