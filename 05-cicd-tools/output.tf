output "jenkins_url" {
  value = "http://${module.jenkins.public_ip}:8080"
}

output "jenkins_agent_private_ip" {
  value = module.jenkins_agent.private_ip
}