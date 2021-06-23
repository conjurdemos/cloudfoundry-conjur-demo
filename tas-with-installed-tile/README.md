# cloudfoundry-conjur-demo

**Please note that this demo is for Conjur Open Source or Enterprise only**

In this demo, we will:
- Create a Conjur service instance in a demo org / space.
- Load Conjur policy to create a secret, and ensure any apps in the demo space
  will have access to the secret.
- Deploy a sample application to the demo space.
- Verify that the Conjur service broker successfully granted the sample app a
  Conjur identity, and that the identity was used to successfully retrieve the
  secret we created from Conjur.

## Requirements

To run this demo, you will need:
- A running [VMWare Tanzu Application Service](https://tanzu.vmware.com/application-service)
  (TAS) foundation, v2.0+.
- A running [CyberArk Conjur Enterprise](https://docs.cyberark.com/Product-Doc/OnlineHelp/AAM-DAP/Latest/en/Content/Deployment/platforms/platforms.html)
  (formerly DAP) cluster or [CyberArk Conjur Open Source](https://docs.conjur.org/Latest/en/Content/OSS/Installation/Install_methods.htm)
  instance, v11+.
- [Summon](https://cyberark.github.io/summon) installed on your local machine.

### Before you begin

To prepare to run this demo:

- Ensure you are working from the `tas-with-installed-tile` directory.
- Set the following environment variables so that we can load policy to define a
  secret and entitlements in a policy branch in this demo:
  - `CONJUR_POLICY`: the policy branch used to configure your TAS tile. This is
    where host identities are automatically added by the service broker.
  - `CONJUR_ACCOUNT`: the account name for your Conjur instance.
  - `CONJUR_AUTHN_LOGIN`: the identity of a Conjur user who can load a policy
    into the `root` branch.
  - `CONJUR_AUTHN_API_KEY`: the API key of your Conjur user.
  - `CONJUR_APPLIANCE_URL`: the URL of your Conjur instance. When using a
    high-availability master cluster, this should be set to the URL of the
    master load balancer.
  - `CONJUR_SSL_CERTIFICATE`: the PEM-encoded x509 CA certificate chain for your
     Conjur instance, provided as a string. This value may be obtained by
     running the command:
     ```sh-session
     $ openssl s_client -showcerts -servername [CONJUR_INSTANCE_DNS_NAME] \
       -connect [CONJUR_INSTANCE_DNS_NAME]:443 < /dev/null 2> /dev/null \
       | sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p'
     -----BEGIN CERTIFICATE-----
     ...
     -----END CERTIFICATE-----
     ```

     To populate this variable, you may dump the output of this command to a
     file `conjur.pem` and load the variable by running:
     ```
     export CONJUR_SSL_CERTIFICATE="$(cat conjur.pem)"
     ```
- Log in to your TAS foundation using `cf login`.
- Create a `cyberark-demo` org in your TAS foundation:
  ```
  cf create-org cyberark-demo
  cf target -o cyberark-demo
  ```

**IMPORTANT:** Running these demo scripts will:
- Add and remove spaces from the `cyberark-demo` org in your TAS foundation.
- Update Conjur policy, by:
  - Adding a new policy branch with the demo secret and entitlements.
  - Adding new policy branches for the demo org / space and a demo app identity.

## Running the demo

The numbered demo scripts are located in [`bin/`](./bin/), and they run through
the four steps outlined at the top of this README. There is a `./bin/start` script
that will run through all of the steps for you, but we recommend running them
one by one and looking at each to understand the commands they are running and
what those commands do.

The final script [./bin/4-print-summary](./bin/4-print-summary) will output a
summary of what changes have been made and how to access your running sample app.
Navigate to the sample app URL in your browser; you will see that the app has
access to the secrets that it retrieved from Conjur using the Conjur Buildpack,
with machine identity provided by the Conjur Service Broker.

To verify that the service is in fact retrieving the actual secret from Conjur,
you can rotate the secret and then restage the app, and it will display the new
secret value that you set. We have included a [rotate script](bin/rotate) for your
convenience that will allow you to do that. To use it, run:
`./bin/rotate [APPEND_STRING]`

The rotate script appends a random number to the end of the original secret
values, unless you specify an `APPEND_STRING` argument to the script - in that
case, the script appends your string to the original secret values. It then
restages the app, so that if you refresh your browser window you will see the
updated secret values in your application.
