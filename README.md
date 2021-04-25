# dockerTest

Construir imagen docker
docker build . -t my_docker

Correr docker:
docker run -d --name my_docker_test1 --rm my_docker

Ver logs del container:
docker logs -f my_docker_test1

Correr docker y ver logs:
docker run -d --name my_docker_test1 --rm my_docker && docker logs -f my_docker_test1

Para un docker con flask se levanta el docker así: docker run -d -p 56733:8080 --name my_docker_test1 --rm my_docker