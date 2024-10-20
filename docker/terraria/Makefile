TMOD_VER := v2024.08.3.1

build:
	docker build -t ghcr.io/kumorikarasu/tmodloader:${TMOD_VER} --build-arg TMOD_VER="${TMOD_VER}" .

push:
	docker push ghcr.io/kumorikarasu/tmodloader:${TMOD_VER}
