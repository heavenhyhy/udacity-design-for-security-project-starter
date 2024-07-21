#### Cloudformation stacks

resource "aws_cloudformation_stack" "s3" {
  name = "c3-s3"
  template_body = file("../cloudformation/c3-s3.yaml")
}

resource "aws_cloudformation_stack" "vpc" {
  depends_on = [aws_cloudformation_stack.s3]

  name = "c3-vpc"
  template_body = file("../cloudformation/c3-vpc.yaml")
}

resource "aws_key_pair" "ssh" {
  key_name   = "Udacity SSH Key"
  public_key = file("../.ssh/id_rsa.pub")
}

resource "aws_cloudformation_stack" "app" {
  depends_on = [aws_cloudformation_stack.vpc]

  name = "c3-app"
  capabilities = ["CAPABILITY_IAM"]
  parameters = {
    ParameterKey = "KeyPair"
    ParameterValue = aws_key_pair.ssh.key_name
  }
  template_body = file("../cloudformation/c3-app.yaml")
}
