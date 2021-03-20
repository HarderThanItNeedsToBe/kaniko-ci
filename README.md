# kaniko-ci

This is a build container that takes Kaniko and lifts it into a more useful image (ubuntu) so that other tools can be
used alongside it (git, make, etc). This is technically not supported by kaniko, but so far it works and makes building
pipelines much easier.

We use the actual Kaniko repo as a submodule, and we build the container by appending our `Dockerfile` onto the end of
their `Dockerfile_debug`. This way we are still staying true to how kaniko is meant to be built; but we can add our own
tools in at the end as well as push our container to our own registry.