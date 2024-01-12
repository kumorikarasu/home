TMOD_VER := v2023.10.3.0

build:
	docker build -t kumorikarasu/tmodloader:${TMOD_VER} --build-arg MOD_VER="${TMOD_VER}" . --no-cache

push:
	docker push kumorikarasu/tmodloader:${TMOD_VER}
