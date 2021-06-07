locals {
  filename = "signed_url_stdout.txt"
}

resource "null_resource" "latest_package" {
  provisioner "local-exec" {
    command = "gsutil ls -l  gs://${var.gcp_bucket}/omnibus/pkg/${var.branch}/el/7/scalr-agent-*.rpm | sort -k 2 | tail -n 2 | head -1 | cut -d ' ' -f 6 > ${local.filename}"
  }
  triggers = {
    keep = formatdate("DD-MM-YYYY", timestamp())
  }
}

data "local_file" "url" {
  filename   = local.filename
  depends_on = [null_resource.latest_package]
}
