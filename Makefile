.PHONY: push

version := $$(echo "$$(cd ./kaniko && git describe)-$$(git rev-parse --short HEAD)")

push:
	docker buildx rm "build-$(version)" || true
	docker buildx create --platform linux/amd64 --use --name "build-$(version)"
	printf "$$(cat kaniko/deploy/Dockerfile_debug)\n\n$$(cat Dockerfile)" | docker buildx build --platform linux/amd64 \
		-f - \
		-t containers.harderthanitneedstobe.com/kaniko-ci:latest \
		-t containers.harderthanitneedstobe.com/kaniko-ci:$(version) \
		-t ghcr.io/harderthanitneedstobe/kaniko-ci:latest \
		-t ghcr.io/harderthanitneedstobe/kaniko-ci:$(version) \
		--push ./kaniko
