
# twilio-dev Container

## Features

The purpose of this container is to get the **Serverless Toolkit** for Twilio setup within a container environment.  This includes:

- [twilio-cli](https://github.com/twilio/twilio-cli)
- [twilio-run](https://github.com/twilio-labs/twilio-run)
- [create-twilio-function](https://github.com/twilio-labs/create-twilio-function)
- [plugin-serverless](https://github.com/twilio-labs/plugin-serverless)

This container additionally provides the following benefits:

twilio-cli
- View ngrok web interface (127.0.0.1:4040) on host
- Map in ngrok.yml for easy configuration changes
- Load .env file on container startup to configure twilio-cli
- Autocomplete setup for bash

twilio-run
- VS code debugger configuration to attach to running Twilio functions/assets
- Expose Twilio functions/assets via ngrok
- View ngrok web interface (127.0.0.1:4040) on host
- Map in ngrok.yml for easy configuration changes
- Map in host system code/asset as a volume
- .env file to configure twilio-run/context variables
- node_modules mounted to a virtual volume to allow persistence and avoid clash with host
- npm scripts for running twilio-run (on port 5566)
  - start - live changes
  - remote - live changes, ngrok tunnel
  - debug - live changes, ngrok tunnel, debugger listening on port 5858

create-twilio-function
- Will read environment variables to create new Twilio Function project

Python
- VS code debugger configuration to attach to running Python script (port 5678)
- Python sample with [ptvsd](https://github.com/microsoft/ptvsd) configured

## ngrok Configuration

ngrok configuration is control via an **ngrok.yml** file that is mapped into the container. It is possible to provide **authtoken** for extended duration on ngrok tunnel time.

More information on configuration options can be found at - https://ngrok.com/docs#config

## Configuring twilio-cli

To properly configure twilio-cli it is necessary to supply **TWILIO_ACCOUNT_SID** and **TWILIO_AUTH_TOKEN**. Sample files have been provided in the root directory and would need to be renamed excluding the **.sample** extension.

## Configuring twilio-run

twilio-run will by default load **.env** in the directory where it is run. To properly configure twilio-run it is necessary to supply **ACCOUNT_SID** and **AUTH_TOKEN** with valid values.  This setup with enable calls to ```context.getTwilioClient()``` to provide a valid Twilio client object. Sample files have been provided and would need to be renamed excluding the **.sample** extension. Any context variable should also be defined in this file.

## scripts

Within the **scripts** folder there are:

- *-delete-volume - deletes any volume(s) used by the container
- *-rebuild - force rebuild of the container
- *-run - executes docker-compose to bring up the container with ports mapped and running /bin/bash

There are **.sh** file(s) for Unix-like systems and **.cmd** file(s) for Windows-based systems that provide proper commands. It may be necessary to modify these commands to run as an administrator.

## Usage

If changes are made to the **Dockerfile** it may be necessary to rebuild the container image:

```bash
# within the directory containing Dockerfile and docker-compose.yml
docker-compose build
```

or rebuild the entire container:

```bash
../scripts/nix-rebuild.sh
```

### twilio-cli

Once started the container will provide access to /bin/bash where a developer can run any of the twilio-cli commands.

```bash
twilio phone-numbers:list
```
Each command will be run against the supplied **TWILIO_ACCOUNT_SID** and **TWILIO_AUTH_TOKEN**.

### src

The **src** directory on the host system will be mapped in as a volume into the container.  This allows for easy edits from a host IDE, such as VS Code, to take effect within the container.  Any files generated in these folders via commands will also be available on the host system after exiting the container.

#### scratch

The **scratch** directory is created within the host system on load and is prevented from commit via **.gitignore**.  This makes a perfect location for test code and artifacts that will not be part of any commits.

### node_modules

The **node_modules** directory on the host system will not be mapped into the container.  A virtual volume mount will allow storage of container node_modules across executions.  A developer can update **package.json** with additional dependencies and ```npm install``` with the expectation that on next run all local modules will be persisted.  Global node_modules will not be persisted.
