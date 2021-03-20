
build-debug:
	docker buildx rm "build-$$(git rev-parse --short HEAD)" || true
	docker buildx create --platform linux/amd64 --use --name "build-$$(git rev-parse --short HEAD)"
	printf "$$(cat kaniko/deploy/Dockerfile_debug)\n\n$$(cat Dockerfile)" | docker buildx build --platform linux/amd64 \
		-f - \
		-t containers.harderthanitneedstobe.com/kaniko:$$(git rev-parse --short HEAD) ./kaniko \
		--push
