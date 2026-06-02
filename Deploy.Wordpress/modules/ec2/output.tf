output "Public_IP" {
  description = "Wordpress instance public ip"
  value = aws_instance.Wordpress_Instance.public_ip
}
output "Wordpress_Instance_ID" {
  description = "Wordpress instance id"
  value = aws_instance.Wordpress_Instance.id
}