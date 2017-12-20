# cloudfoundry-conjur-demo
Before beginning the demo, you will need to install the Conjur Service Tile for
PCF in the Ops Manager. The Conjur Service Tile for PCF requires that you have a running Conjur instance. You can quickly get Conjur running by visiting [the hosted Conjur page](https://www.conjur.org/get-started/try-conjur.html) to sign up for a hosted Conjur instance. We will use this throughout the demo; keep your Account ID and API Key ready to use.

Once you have installed the Conjur Service Tile for PCF, you can log into your
Cloud Foundry deployment via the command line using `cf login` and target the
org where you would like to deploy this demo with `cf target`. You can verify
that your installation of the Conjur Service Tile for PCF is functioning
correctly by verifying that the `cyberark-conjur` service is available when you
run `cf marketplace`.

**WARNING:** Running the demo scripts will:
- Add and remove spaces named `demo` from your deployment, so make sure you choose an org that does not have an existing `demo` space.
- Replace the `root` policy in your Conjur account

Have the Conjur account and the API key for your `admin` Conjur user at the ready, and pass them as arguments to the start-up script:
`./bin/start CONJUR_ACCOUNT CONJUR_API_KEY`

The start-up script clears out your workspace [TODO]
It creates a `demo` space within your org, creates the Conjur service, and deploys the sample application in `app` to PCF. It loads a Conjur policy that grants access to some database secrets to the application host, and binds the application to the Conjur service.

The start-up script will output the URL for the test app. If you navigate to this URL, you will see that the app has access to the secrets that it retrieved from Conjur using its buildpack, with machine identity provided by the Conjur Service Broker.

To verify that the service is in fact retrieving the actual secrets from Conjur, you can rotate the secrets and then restage the app, and it will display the new secret values that you set. Directions for that follow.

Rotate secrets:

```
docker run -d -it -v $PWD:/work -w /work \
  -e CONJUR_AUTHN_API_KEY="$API_KEY" \
  -e APP_HOST_NAME="$APP_HOST_NAME" \
  -e CONJUR_AUTHN_LOGIN="admin" \
  -e CONJUR_ACCOUNT="$ACCOUNT" \
  -e CONJUR_APPLIANCE_URL="eval.conjur.org" \
  --entrypoint bash conjurinc/cli5 -c "
conjur variable values add app/database/username 'a database username 123';
conjur variable values add app/database/password 'a database password 456';
conjur variable values add app/stripe/private_key 'a stripe private_key 789'
"
```

Then restage the app:

```
cf restage hello-world
```

Observe the new secret values by refreshing the `hello-world` app in your browser window.
