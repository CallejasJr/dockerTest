# dockerTest

Construir imagen docker
docker build . -t my_docker

Correr docker:
docker run -d --name my_docker_test1 --rm my_docker

Ver logs del container:
docker logs -f my_docker_test1

Correr docker y ver logs:
docker run -d --name my_docker_test1 --rm my_docker && docker logs -f my_docker_test1