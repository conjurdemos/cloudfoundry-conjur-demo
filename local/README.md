# cloudfoundry-conjur-demo
To run this demo, you must be working from the `local` directory.

For simplicity, in this demo the Service Broker app is deployed to the same org / space as the demo application. In practice, the Service Broker app should be
deployed to its own org and space that is only accessible to admin CF users.

In addition, throughout this demo we assume you are logged into PCF Dev as an admin user, which enables you to install the Service Broker / Buildpacks and upload the demo app. In practice, the Service Broker / Buildpacks will be installed by a CF admin user, but the applications will be deployed to CF by developer users.

For more information about how the Service Broker and Buildpack should be used in
practice, see the [Cloud Foundry integration tutorial](https://www.conjur.org/tutorials/integrations/cloud-foundry.html).

## Preparing to run the demo
**YOU MUST HAVE [PCF DEV](https://pivotal.io/pcf-dev) INSTALLED** to run this demo.

If you have not worked with PCF Dev before, it is a great idea to work through [Pivotal's introduction](https://pivotal.io/platform/pcf-tutorials/getting-started-with-pivotal-cloud-foundry-dev/introduction), which will help you install PCF Dev, the CF CLI, and deploy a sample app.

Once you have PCF Dev installed, running, and logged in, you can run through this demo.

## Running the demo
This demo will work with either v4 or v5 Conjur. Before starting, set your `CONJUR_VERSION` environment variable to the version you would like to demo (either 4 or 5).

To run the demo, you can step through the scripts in [./bin/](bin/) one by one in order, or you can run [./bin/start](bin/start) to run the suite.

Visit `http://hello-world.local.pcfdev.io` and observe the running app displaying secrets retrieved from Conjur by the build-pack, with machine identity provided via the service broker.

## Verifying functionality
To verify that the service is in fact retrieving the actual secrets from Conjur, you can rotate the secrets and then restage the app, and it will display the new secret values that you set. We have included a [script](bin/rotate) for your convenience that will allow you to do that. To use it, run `./bin/rotate`.

The rotate script appends a random number to the end of the original secret values, unless you specify an `APPEND_STRING` - in that case, the script appends your string to the original secret values. It then restages the app, so that if you refresh your browser window you will see the updated secret values in your application.
