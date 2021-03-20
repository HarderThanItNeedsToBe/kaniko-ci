
push:
	docker buildx rm "build-$$(git rev-parse --short HEAD)" || true
	docker buildx create --platform linux/amd64 --use --name "build-$$(git rev-parse --short HEAD)"
	printf "$$(cat kaniko/deploy/Dockerfile_debug)\n\n$$(cat Dockerfile)" | docker buildx build --platform linux/amd64 \
		-f - \
		-t containers.harderthanitneedstobe.com/kaniko-ci:latest \
		-t containers.harderthanitneedstobe.com/kaniko-ci:$$(git rev-parse --short HEAD) \
		-t ghcr.io/harderthanitneedstobe/kaniko-ci:latest \
		-t ghcr.io/harderthanitneedstobe/kaniko-ci:$$(git rev-parse --short HEAD) \
		--push ./kaniko
