region     = "eu-west-1"
vpc_cidr   = "192.168.0.0/16"
profile    = "femi-devop"

//subnet configs
networks = {
   zones = [
      "eu-west-1a",
      "eu-west-1b",
      "eu-west-1c",
   ]

   public_subnets = [
      "192.168.1.0/24",
      "192.168.2.0/24",
      "192.168.3.0/24",
   ]

   subnet_name = [
      "web-server-1",
      "web-server-2",
      "web-server-3",
   ]
}

tags = {
  project_name      = "devop-test"
  owner             = "wipro"
  email             = "femi.okuta@wipro.com"
}
