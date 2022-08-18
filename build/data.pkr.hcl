data "amazon-parameterstore" "security_groups" {
    name = "/foundry/packer/security-groups"
    with_decryption = true
}