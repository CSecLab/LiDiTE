# ditto-nginx

Eclipse Ditto implements authentication by delegating it to other authentication providers.

One of these providers is an "authenticating proxy": a reverse proxy that performs HTTP basic authentication and indicates the user asserted identity in headers sent to the backend services.

In the case of ditto, such header is called `x-ditto-pre-authenticated` and contains a payload of the format `<identity-provider>:<identity>`.

This implementation creates identities of the form `nginx:<http-basic-username>`.

## Configuration

In order to configure the user identities, an environment variable `FDT_CREDENTIALS` has to be set in the container, its format is (EBNF):

```text
credentials = credential [ " " credentials ]
credential = username ":" password
```

For instance, in order to define three users `alice`, `bob` and `charlie`:

```sh
FDT_CREDENTIALS=alice:alicepass bob:bobpass charlie:charliepass
```

These users will have a corresponding Ditto identity of `nginx:alice`, `nginx:bob` and `nginx:charlie`.
