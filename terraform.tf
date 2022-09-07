provider &quot;aws&quot; {
region = &quot;ap-south-1&quot;
profile = &quot;default&quot;
}

resource &quot;aws_instance&quot; &quot;web&quot; {
ami = &quot;ami-00bf4ae5a7909786c&quot;
instance_type = &quot;t2.micro&quot;
subnet_id = aws_subnet.main.id
tags = {
Name = &quot;My terraform OS 14&quot;
}
}

resource &quot;aws_ebs_volume&quot; &quot;st1&quot;{
availability_zone = aws_instance.web.availability_zone
size = 10
tags = {
Name = &quot;Terraform HD&quot;

}
}

resource &quot;aws_volume_attachment&quot; &quot;ebs_att&quot;{
device_name=&quot;/dev/sdh&quot;
volume_id = aws_ebs_volume.st1.id
instance_id = aws_instance.web.id
}

resource &quot;aws_vpc&quot; &quot;mainvpc&quot; {
cidr_block = &quot;10.1.0.0/16&quot;
tags = {
Name = &quot;Terraform vpc&quot;
}
}

resource &quot;aws_default_security_group&quot; &quot;default&quot; {
vpc_id = aws_vpc.mainvpc.id

ingress {
protocol = -1
self = true
from_port = 0
to_port = 0

}

egress {
from_port = 0
to_port = 0
protocol = &quot;-1&quot;
cidr_blocks = [&quot;0.0.0.0/0&quot;]
}
}
resource &quot;aws_subnet&quot; &quot;main&quot; {
vpc_id = aws_vpc.mainvpc.id
cidr_block = &quot;10.1.0.0/24&quot;

tags = {
Name = &quot;TF subnet&quot;
}
}

provider &quot;google&quot; {
project = &quot;majorproject-319008&quot;
region = &quot;us-central1&quot;
credentials = &quot;majorproject-key.json&quot;
}

resource &quot;google_compute_instance&quot; &quot;skucet&quot; {
name = &quot;skucet&quot;
machine_type = &quot;e2-medium&quot;
zone = &quot;us-central1-a&quot;

boot_disk {
initialize_params {
image = &quot;debian-cloud/debian-9&quot;
}
}
network_interface {
network = &quot;default&quot;
}

}
