# cloudfoundry-conjur-demo

**Please note that this demo is for Conjur v5 only**

To run this demo, you must be working from the `local` directory.

For simplicity, in this demo the Service Broker app is deployed to the same
org / space as the demo application. In practice, the Service Broker app should be
deployed to its own org and space that is only accessible to admin CF users.

In addition, throughout this demo we assume you are logged into CF Dev as an admin user,
which enables you to install the Service Broker / Buildpacks and upload the demo app.
In practice, the Service Broker / Buildpacks will be installed by a CF admin user,
but the applications will be deployed to CF by developer users.

If you want to test this workflow out, the demo is set up so that the CF Dev
user `user` has Developer access to the `demo-org` org and `demo-space` space
where the app will be deployed. To demonstrate this workflow, you can run
scripts 0-4 as the CF Dev `admin` user, and log in as the CF Dev non-admin `user`
user to run the remaining scripts.

For more information about how the Service Broker and Buildpack should be used in
practice, see the [Cloud Foundry integration tutorial](https://www.conjur.org/tutorials/integrations/cloud-foundry.html).

## Preparing to run the demo
**YOU MUST HAVE [CF DEV](https://github.com/cloudfoundry-incubator/cfdev) INSTALLED** to run this demo.

> We tested this demo to run with the [CF Dev 0.0.12](https://github.com/cloudfoundry-incubator/cfdev/releases/tag/v0.0.12)

## Running the demo
Before starting:
* Ensure that your CloudFoundry CLI (`cf`) is targeting your CF Dev instance. Instructions for this can be found at
  https://github.com/cloudfoundry-incubator/cfdev. For CF Dev `v0.0.12` this can be accomplished by running:
  ```
  cf login -a https://api.dev.cfdev.sh --skip-ssl-validation
  ```

To run the demo, you can step through the scripts in [./bin/](bin/) one by one in order, or you can run [./bin/start](bin/start) to run the suite.

Visit `http://hello-world.dev.cfdev.sh` and observe the running app displaying secrets retrieved from Conjur by the build-pack, with machine identity provided via the service broker.

## Verifying functionality
To verify that the service is in fact retrieving the actual secrets from Conjur, you can rotate the secrets and then restage the app, and it will display the new secret values that you set. We have included a [script](bin/rotate) for your convenience that will allow you to do that. To use it, run `./bin/rotate`.

The rotate script appends a random number to the end of the original secret values, unless you specify an `APPEND_STRING` - in that case, the script appends your string to the original secret values. It then restages the app, so that if you refresh your browser window you will see the updated secret values in your application.
