module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "~> 19.0"
  cluster_name    = "accuknox-eks-cluster"
  cluster_version = "1.27"

  cluster_endpoint_public_access = true

  vpc_id     = "vpc-0de3cb2d0f6a6a1c2"
  subnet_ids = ["subnet-092d4e3f3e251a94d", "subnet-086031210aee5195b", "subnet-032803f803df91184", "subnet-032803f803df91184", "subnet-03625795b84ddf68a"]

  tags = {
    environment = "development"
    application = "wisecow-app"
  }

  eks_managed_node_groups = {
    dev = {
      min_size           = 1
      max_size           = 3
      desired_size       = 2
      security_group_ids = [aws_security_group.my_node_group_sg.id]
      instance_types     = ["t2.medium"]
    }
  }
}