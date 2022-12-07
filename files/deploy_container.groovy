def deploy() {
  try {
    echo "This is your username for DockerHub account : ${params.dockerhub_user}"
    sh "docker run -d -p 5002:80 --name flask_from_jenkins ${params.dockerhub_user}/jenkins:3.1"
  } catch(err) {
    sh "docker rm -f flask_from_jenkins"
    sh "docker run -d -p 5002:80 --name flask_from_jenkins ${params.dockerhub_user}/jenkins:3.1"
  }
}

return this