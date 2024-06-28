resource "aws_dynamodb_table" "Employees" {
  name             = "Employees"
  hash_key         = "id"
  billing_mode = "PROVISIONED" 
  read_capacity = 10  
  write_capacity = 10

  attribute {
    name ="id"
    type = "S"
  }
}