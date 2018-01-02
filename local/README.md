# cloudfoundry-conjur-demo
To run this demo, you must be working from the `local` directory.

## Preparing to run the demo
Before starting the demo, ensure you have PCF Dev running and you are logged in.
If you are not logged in, you will need to run `cf login -a api.local.pcfdev.io --skip-ssl-validation` before running the demo script.

## Running the demo
To start the demo, run `./bin/start`.

Visit `http://hello-world.local.pcfdev.io` and observe the running app displaying secrets retrieved from Conjur by the build-pack, with machine identity provided via the service broker.

## Verifying functionality
To verify that the service is in fact retrieving the actual secrets from Conjur, you can rotate the secrets and then restage the app, and it will display the new secret values that you set. We have included a [script](bin/rotate) for your convenience that will allow you to do that. To use it, run `./bin/rotate`.

The rotate script appends a random number to the end of the original secret values, unless you specify an `APPEND_STRING` - in that case, the script appends your string to the original secret values. It then restages the app, so that if you refresh your browser window you will see the updated secret values in your application.
