# cloudfoundry-conjur-demo

**Please note that this demo is for Conjur v5 only**

This repository contains two separate scripts for demonstrating that an
application deployed to Cloud Foundry can access secrets stored in a Conjur
instance. 

- The [local](local/) directory includes a script that will stand up a local
Conjur instance in a container, manually deploy the Conjur Service Broker to
a locally running instance of [CF Dev](https://github.com/cloudfoundry-incubator/cfdev), and deploy
the test [app](app/) to PCF to verify it can retrieve secrets from Conjur.

- The [PCF with installed tile](pcf-with-installed-tile/) directory is for **Conjur engineers only**; it assumes that
you have access to a PCF installation and that you have an existing Conjur
installation up and running. It requires that you install the Conjur Service Broker for
PCF service tile in the Ops Manager of your running PCF installation, and it
deploys the test [app](app/) to PCF to verify it can retrieve secrets from Conjur.

## Contributing

We welcome contributions of all kinds to this repository. For instructions on how to get started and descriptions of our development workflows, please see our [contributing
guide][contrib].

[contrib]: https://github.com/conjurdemos/cloudfoundry-conjur-demo/blob/master/CONTRIBUTING.md

## License

Copyright 2018 CyberArk

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
