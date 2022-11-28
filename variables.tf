variable "internal" {
  description = "Whether the ALB is public or private."
}

variable "name" {
  description = "The name of the ALB."
}

variable "network" {
  description = "The network to use"
  type = object({
    private_subnets = list(string)
    public_subnets  = list(string)
    vpc_id          = string
  })
}

variable "wildcard_certificate" {
  description = "The wildcard certificate to use."
  type = object({
    arn = string
  })
}
