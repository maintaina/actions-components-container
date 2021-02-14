# actions-components-container

This container facilitates clean-room application of the horde/components app.
The repo also sports a WIP github action

Unit under Test/Manipulation goes to /srv/www/horde-uut

The components tool is installed under /srv/www/horde-components and the bin is at /srv/www/horde-components/vendor/bin


## How to use the Github Action directly

TODO


## How to get the container image

You may want to get the container for usage outside public github, maybe using Gitlab oder some homegrown toolchain

Login to ghcr.io using your github user and a Personal Access Token

```bash
docker login ghcr.io
docker pull ghcr.io/maintaina/actions-components-container/horde-components]
```

## Building the image

To build this, your docker build command MUST convey a variable COMPOSER_PAT to the build env
This must contain a github PAT with no/any scope.