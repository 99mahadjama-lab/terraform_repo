output "Wordpress_DB_Instance" {
  value = aws_db_instance.wordpress
}


output "Wordpress_DB_ID" {
  value = aws_db_instance.wordpress.id
}

output "Wordpress_DB_Address" {
  value = aws_db_instance.wordpress.address
}
