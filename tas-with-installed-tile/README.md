# cloudfoundry-conjur-demo

**Please note that this demo is for Conjur OSS or DAP only**

To run this demo, you must be working from the `tas-with-installed-tile` directory.

## Steps to take before running demo
Before beginning the demo, you will need to:
- Install the Conjur Service Tile for VMWare Tanzu in the Ops Manager. The
  Conjur Service Tile for VMWare Tanzu must be configured with credentials for a
  running Conjur instance.
- Install [`summon`](https://github.com/cyberark/summon).
- Install [`summon-keyring`](https://github.com/conjurinc/summon-keyring)
  provider for Summon.
- Log into your Cloud Foundry deployment via the command line using `cf login`
  and run
  ```
  cf create-org cyberark-demo
  cf target -o cyberark-demo
  ```
  You can verify that your installation of the Conjur Service Tile for VMWare
  Tanzu is functioning correctly by verifying that the `cyberark-conjur` service
  is available when you run `cf marketplace`.

**WARNING:** Running the demo scripts will:
- Add and remove spaces named `cyberark-conjur-demo` from your deployment, so
  make sure you choose an org that does not have an existing `demo` space.
- Update the `root` policy in your Conjur account

### Conjur Setup
Install [Summon](https://github.com/cyberark/summon) and the
[Summon-Keyring provider](https://github.com/conjurinc/summon-keyring) so that
the demo script can access the Conjur account information when needed.

Store the Conjur Account ID and API Key in the OSX keychain by calling:
```
$ security add-generic-password -s "summon" -a "conjur/account" -w "ACCOUNTID"
$ security add-generic-password -s "summon" -a "conjur/api_key" -w "APIKEY"
```

## Running the demo
Our demo script will be modifying Conjur policy to add the application host to
a group with access to the application's secrets, so it will need access to
Conjur account info. Since we have stored this info in the OSX keyring, if you
have the [keyring provider](https://github.com/conjurinc/summon-keyring)
available, we can run the [demo script](bin/start) by calling
`summon -p keyring.py ./bin/start`.

The demo scripts are configured to work with ["Try Conjur"](https://www.conjur.org/get-started/try-conjur.html)
by default (`eval.conjur.org`). To use the scripts with a different Conjur
instance, set the `APPLIANCE_URL` environment variable before running the demo
scripts:
```
$ export APPLIANCE_URL="{your_appliance_url}"
```

### What the script does
The start-up script clears out your workspace - it deletes any previously
deployed `hello-world` apps in the demo space, removes the Conjur service, and
removes the demo space.

It then creates a `demo` space within your org, creates the Conjur service, and
deploys the sample application in `app` to TAS. It loads a Conjur policy that
grants access to some database secrets to the application host, and binds the
application to the Conjur service.

### Verifying functionality
The start-up script will output the URL for the test app. If you navigate to
this URL, you will see that the app has access to the secrets that it retrieved
from Conjur using its buildpack, with machine identity provided by the Conjur
Service Broker.

To verify that the service is in fact retrieving the actual secrets from Conjur,
you can rotate the secrets and then restage the app, and it will display the new
secret values that you set. We have included a [script](bin/rotate) for your
convenience that will allow you to do that. To use it, run:
`summon -p keyring.py ./bin/rotate [APPEND_STRING]`

The rotate script appends a random number to the end of the original secret
values, unless you specify an `APPEND_STRING` argument to the script - in that
case, the script appends your string to the original secret values. It then
restages the app, so that if you refresh your browser window you will see the
updated secret values in your application.
