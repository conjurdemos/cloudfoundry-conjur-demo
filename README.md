# cloudfoundry-conjur-demo

**Please note that this demo is for Conjur OSS or DAP only**

This repository contains two separate scripts for demonstrating that an
application deployed to Cloud Foundry can access secrets stored in a Conjur
instance. 

- The [local](local/) directory includes a script that will stand up a local
Conjur instance in a container, manually deploy the Conjur Service Broker to
a locally running instance of [CF Dev](https://github.com/cloudfoundry-incubator/cfdev), and deploy
the test [app](app/) to CF to verify it can retrieve secrets from Conjur.

- The [TAS with installed tile](tas-with-installed-tile/) directory is intended
  for **development purposes only**; it assumes that you have access to a VMWare
  Tanzu Application Service (TAS) installation and that you have an existing
  Conjur or DAP installation up and running. It requires that you install the
  Conjur Service Broker for VMWare Tanzu service tile in the Ops Manager of your
  running TAS installation, and it deploys the test [app](app/) to TAS to verify
  it can retrieve secrets from Conjur.

## Contributing

We welcome contributions of all kinds to this repository. For instructions on
how to get started and descriptions of our development workflows, please see our
[contributing guide][contrib].

[contrib]: https://github.com/conjurdemos/cloudfoundry-conjur-demo/blob/master/CONTRIBUTING.md

## License

This repository is licensed under Apache License 2.0 - see [`LICENSE`](LICENSE)
for more details.
