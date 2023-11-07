TMOD_VER := v2023.09.3.2

build:
	docker build -t kumorikarasu/tmodloader:${TMOD_VER} --build-arg MOD_VER="${TMOD_VER}" . --no-cache

push:
	docker push kumorikarasu/tmodloader:${TMOD_VER}
