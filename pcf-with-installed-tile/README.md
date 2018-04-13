# cloudfoundry-conjur-demo

To run this demo, you must be working from the `pcf-with-installed-tile` directory.

## Steps to take before running demo
Before beginning the demo, you will need to:
- Install the Conjur Service Tile for PCF in the Ops Manager. The Conjur Service Tile for PCF must be configured with credentials for a running Conjur instance. You can quickly get Conjur running by visiting [the hosted Conjur page](https://www.conjur.org/get-started/try-conjur.html) to sign up for a hosted Conjur instance. We will use this throughout the demo; keep your Account ID and API Key ready to use.
- Log into your Cloud Foundry deployment via the command line using `cf login` and run
  ```
  cf create-org cyberark-demo
  cf target -o cyberark-demo
  ```
  You can verify that your installation of the Conjur Service Tile for PCF is functioning correctly by verifying that the `cyberark-conjur` service is available when you run `cf marketplace`.

**WARNING:** Running the demo scripts will:
- Add and remove spaces named `cyberark-conjur-demo` from your deployment, so make sure you choose an org that does not have an existing `demo` space.
- Update the `root` policy in your Conjur account

### Steps for Conjur version 5
If connecting to a v5 Conjur instance, install [Summon](https://github.com/cyberark/summon) and the [Summon-Keyring provider](https://github.com/conjurinc/summon-keyring) so that the demo script can access the Conjur account information when needed.

Store the Conjur Account ID and API Key in the OSX keychain by calling:
```
$ security add-generic-password -s "summon" -a "conjur_pie/account" -w "ACCOUNTID"
$ security add-generic-password -s "summon" -a "conjur_pie/api_key" -w "APIKEY"
```

### Steps for Conjur version 4
Install version 5.x.x of the Conjur CLI and connect to our hosted Conjur v4 instance by running:
```
conjur init -h https://conjur-pcf.itci.conjur.net -f ~/.conjurrc.pie
export CONJURRC=~/.conjurrc.pie
conjur authn login
```
Authenticate as the `admin` user for the Conjur instance (or another user who has authority to modify `root` policy) - this demo will need to update `root` policy to add the `pcf` policy namespace and the `pcf-admin` user / group.

## Running the demo
Our demo script will be modifying Conjur policy to add the application host to a group with access to the application's secrets, so it will need access to Conjur account info. Since we have stored this info in the OSX keyring, we can run the [demo script](bin/start) by calling
`summon -p keyring.py ./bin/start`.

### What the script does
The start-up script clears out your workspace - it deletes any previously deployed `hello-world` apps in the demo space, removes the Conjur service, and removes the demo space.

It then creates a `demo` space within your org, creates the Conjur service, and deploys the sample application in `app` to PCF. It loads a Conjur policy that grants access to some database secrets to the application host, and binds the application to the Conjur service.

### Verifying functionality
The start-up script will output the URL for the test app. If you navigate to this URL, you will see that the app has access to the secrets that it retrieved from Conjur using its buildpack, with machine identity provided by the Conjur Service Broker.

To verify that the service is in fact retrieving the actual secrets from Conjur, you can rotate the secrets and then restage the app, and it will display the new secret values that you set. We have included a [script](bin/rotate) for your convenience that will allow you to do that. To use it, run:
`summon -p keyring.py ./bin/rotate [APPEND_STRING]`

The rotate script appends a random number to the end of the original secret values, unless you specify an `APPEND_STRING` argument to the script - in that case, the script appends your string to the original secret values. It then restages the app, so that if you refresh your browser window you will see the updated secret values in your application.
