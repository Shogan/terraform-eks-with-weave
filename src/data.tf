data "template_file" "eks_linux_pre_user_data_template" {
  template = "${file("${path.module}//userdata-linux.tpl")}"

  vars = {
    environment     = "${var.environment}"
    region          = "${var.region}"
  }
}