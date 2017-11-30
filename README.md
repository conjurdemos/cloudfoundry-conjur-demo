# cloudfoundry-conjur-demo
To start the demo, run `./bin/start`.

Visit `http://hello-world.local.pcfdev.io` and observe the running app displaying secrets retrieved from Conjur by the build-pack, with machine identity provided via the service broker.

Rotate secrets:

```
docker-compose run --rm -e CONJUR_AUTHN_API_KEY="$(cat tmp/api_key)" --entrypoint bash client -c "
conjur variable values add app/database/username 'a database username 123'
conjur variable values add app/database/password 'a database password 456'
conjur variable values add app/stripe/private_key 'a stripe private_key 789'
"
```

Then restage the app:

```
cf restage hello-world
```

Observe the new secret values at `http://hello-world.local.pcfdev.io`.
