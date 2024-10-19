#!/bin/sh

repo="${1:-kumorikarasu/tmodloader}"

# Get latest version of tmodloader server
GH_TOKEN=$(echo $GH_PAT | base64)
TAG=$(curl -sL https://api.github.com/repos/tModLoader/tModLoader/releases | jq -r "first | .tag_name")
UPLOADED_TAGS=$(curl -H "Authorization: Bearer $GH_TOKEN" -s "https://ghcr.io/v2/${repo}/tags/list" | jq -r ".tags[]")

echo "Repo: $repo"
echo "Latest version of tModLoader server is $TAG"
echo "Checking if tag $TAG exists on ghcr..."
echo "Uploaded tags: $UPLOADED_TAGS"

if echo $UPLOADED_TAGS | grep -q $TAG; then
  echo "Tag $TAG already exists on ghcr"
else
  echo "Tag $TAG does not exist on ghcr"
  echo "Building image..."
fi


# Update dockerfile with tag
sed -i "s/ARG TMOD_VER=.*/ARG TMOD_VER=$TAG/" Dockerfile

# Build image
docker build -t ghcr.io/${repo}:${TAG} --build-arg TMOD_VER="${TAG}" . --no-cache
docker tag ghcr.io/${repo}:${TAG} ghcr.io/${repo}:latest

# Push image
docker push ghcr.io/${repo}:${TAG}
docker push ghcr.io/${repo}:latest
