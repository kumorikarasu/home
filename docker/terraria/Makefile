TMOD_VER := v2024.03.3.4

build:
	docker build -t kumorikarasu/tmodloader:${TMOD_VER} --build-arg TMOD_VER="${TMOD_VER}" . --no-cache

push:
	docker push kumorikarasu/tmodloader:${TMOD_VER}
