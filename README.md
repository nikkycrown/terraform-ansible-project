# terraform-ansible-project

# Terraform Goal;
* Using Terraform, create 3 EC2 instances and put them behind an Elastic Load Balancer.
* After applying my plan, Terraform exports the public IP addresses of the instances to an inventory file.
* Set a domain name with AWS Route53 within my terraform plan, then add an A record for subdomain terraform-test which points to my ELB IP address.

# Ansible Goal;
* Create an Ansible script that uses the inventory file Terraform created to install Apache,
* Set timezone to Africa/Lagos and
* Create a simple HTML page that displays all the content to clearly identify on all 3 EC2 instances.

# End Result;
* when my terraform-test.mydomain is visited, it shows the content from my instances while rotating between the servers as they refresh to display their unique content.
