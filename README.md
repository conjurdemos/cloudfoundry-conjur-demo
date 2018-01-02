# cloudfoundry-conjur-demo
This repository contains two separate scripts for demonstrating that an
application deployed to Cloud Foundry can access secrets stored in a Conjur
instance.

- The [local](local/) directory includes a script that will stand up a local
Conjur instance in a container, manually deploy the Conjur Service Broker to
a locally running instance of [PCF Dev](https://pivotal.io/pcf-dev), and deploy
the test [app](app/) to PCF to verify it can retrieve secrets from Conjur.
  - *Note:* if you are using this version of the demo, you will want to clone
    this repository using `git clone --recursive` to ensure that you also load
    the required git submodules.

- The [PIE](pie/) directory assumes you have an existing Conjur installation up
and running, and that you have access to a PCF installation. In particular,
this demo was built to work with Pivotal's Integration Environment, or PIE - a
hosted deployment of PCF available to Pivotal partners. It requires that you
install the Conjur Service Broker for PCF service tile in the Ops Manager of
your running PCF installation, and it deploys the test [app](app/) to PCF to
verify it can retrieve secrets from Conjur.
