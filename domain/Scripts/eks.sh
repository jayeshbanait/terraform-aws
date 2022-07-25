MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="//"
--//
Content-Type: text/x-shellscript; charset="us-ascii"
#!/bin/bash
set -o xtrace
/etc/eks/bootstrap.sh '${eks_cluster_name}'
--//--
