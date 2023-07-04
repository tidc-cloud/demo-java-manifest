# Vote application chart

A simple distributed application running on Kubernetes.

---

## Architecture

![Architecture diagram](docs/assets/architecture.png)

* A front-end web app `vote` in Python which lets you vote between two options.
* A [Redis](https://hub.docker.com/_/redis/) queue which collects new votes.
* A .NET Core `worker` which consumes votes and stores them in DB.
* A [Postgres](https://hub.docker.com/_/postgres/) database backed by a CSI volume.
* A Node.js `result`  webapp which shows the results of the voting in real time.

**Notes**:

The voting application only accepts one vote per client. It does not register votes if a vote has already been submitted from a client.

This isn't an example of a properly architected perfectly designed distributed app... it's just a simple
example of the various types of pieces and languages you might see (queues, persistent data, etc), and how to
deal with them in Docker at a basic level.

---

## Install release `vote` from local chart source

```sh
NAMESPACE=vote
RELEASE=vote

# Prerequisites: create secret for pulling image
kubectl -n vote create secret docker-registry regcred \
  --from-file=.dockerconfigjson=${HOME}/.docker/config.json \
  -o yaml --dry-run=client | kubectl apply -f -

# Install release
helm -n $NAMESPACE upgrade --install $RELEASE .  \
  -f values-dev.yaml \
  --create-namespace
```

## Uninstall release

```sh
# Uninstall release
helm -n $NAMESPACE uninstall $RELEASE
```

---
