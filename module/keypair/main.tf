#Create Keypair 
resource "aws_key_pair" "capeuteam2" {
  key_name   = var.keypair_name 
  public_key = file(var.keypair)
}