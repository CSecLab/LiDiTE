# ditto-register

In order to perform configuration as code of Ditto policies and things, this executable allows to automatically register policies and things with Ditto.

## Usage

First of all, a directory structure like the following has to be constructed:

```text
policies
 L namespaceName1
    L policy1.json
things
 L namespaceName1
    L thing1.json
```

Structure of the things and policies files are the ones defined on the Ditto project documentation.

The following environment variables have to be set:

- `IT_UNIGE_FDT_DITTO_URL` the Ditto frontend URL
- `IT_UNIGE_FDT_DITTO_USERNAME` the username to use
- `IT_UNIGE_FDT_DITTO_PASSWORD` the password to use
- `IT_UNIGE_FDT_DEFINITIONS_PATH` root path of the directory structure defined above
