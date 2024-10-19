# Get latest version of tmodloader server
TAG=$(curl -sL https://api.github.com/repos/tModLoader/tModLoader/releases | jq -r "first | .tag_name")
UPLOADED_TAGS=$(curl -sL https://hub.docker.com/v2/repositories/kumorikarasu/tmodloader/tags | jq -r ".results[] | .name")

if echo $UPLOADED_TAGS | grep -q $TAG; then
  echo "Tag $TAG already exists on dockerhub"
  exit 1
else
  echo "Tag $TAG does not exist on dockerhub"
  echo "Building image..."
fi


# Update dockerfile with tag
sed -i "s/ARG TMOD_VER=.*/ARG TMOD_VER=$TAG/" Dockerfile

# Build image
docker build -t ghcr.io/kumorikarasu/tmodloader:${TAG} --build-arg TMOD_VER="${TAG}" . --no-cache
docker tag ghcr.io/kumorikarasu/tmodloader:${TAG} ghcr.io/kumorikarasu/tmodloader:latest

# Push image
docker push ghcr.io/kumorikarasu/tmodloader:${TAG}
docker push ghcr.io/kumorikarasu/tmodloader:latest
