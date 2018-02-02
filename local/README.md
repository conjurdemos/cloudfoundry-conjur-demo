# cloudfoundry-conjur-demo
To run this demo, you must be working from the `local` directory.

## Preparing to run the demo
**YOU MUST HAVE [PCF DEV](https://pivotal.io/pcf-dev) INSTALLED** to run this demo.

If you have not worked with PCF Dev before, it is a great idea to work through [Pivotal's introduction](https://pivotal.io/platform/pcf-tutorials/getting-started-with-pivotal-cloud-foundry-dev/introduction), which will help you install PCF Dev, the CF CLI, and deploy a sample app.

Once you have PCF Dev installed, running, and logged in, you can run through this demo.

## Running the demo
To run the demo, you can step through the scripts in [./bin/](bin/) one by one in order, or you can run [./bin/start](bin/start) to run the suite.

Visit `http://hello-world.local.pcfdev.io` and observe the running app displaying secrets retrieved from Conjur by the build-pack, with machine identity provided via the service broker.

## Verifying functionality
To verify that the service is in fact retrieving the actual secrets from Conjur, you can rotate the secrets and then restage the app, and it will display the new secret values that you set. We have included a [script](bin/rotate) for your convenience that will allow you to do that. To use it, run `./bin/rotate`.

The rotate script appends a random number to the end of the original secret values, unless you specify an `APPEND_STRING` - in that case, the script appends your string to the original secret values. It then restages the app, so that if you refresh your browser window you will see the updated secret values in your application.
