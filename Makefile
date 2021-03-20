
build-debug:
	docker buildx rm "build-$$(git rev-parse --short HEAD)" || true
	docker buildx create --platform linux/amd64 --use --name "build-$$(git rev-parse --short HEAD)"
#	docker buildx build --platform linux/amd64 \
#		-o type=docker \
#		-f kaniko/deploy/Dockerfile_debug \
#		-t containers.harderthanitneedstobe.com/kaniko ./kaniko
	docker buildx build --platform linux/amd64 \
		-f Dockerfile \
		--push \
		-t containers.harderthanitneedstobe.com/kaniko-test .
