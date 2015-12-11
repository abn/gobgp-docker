# GoBGP Containers

This project puts [gobgp](https://github.com/osrg/gobgp) binaries in scratch docker containers. It is available on Docker Hub as [gobgp](https://registry.hub.docker.com/u/alectolytic/gobgp/) and [gobgpd](https://registry.hub.docker.com/u/alectolytic/gobgpd/); and can be pulled using the following command.

```sh
docker pull alectolytic/gobgp
docker pull alectolytic/gobgpd
```

You will note that this is a tiny image.
```
$ docker images | grep docker.io/alectolytic/gobgp
docker.io/alectolytic/gobgp     1.2   a3c7ed869942    5 minutes ago   9.491 MB
docker.io/alectolytic/gobgpd    1.2   b879df053a1f    6 minutes ago   10.98 MB
```

## Quickstart

```sh
docker run --rm -it alectolytic/gobgpd
```
