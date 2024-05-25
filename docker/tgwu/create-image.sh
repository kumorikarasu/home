
# Clone the repository
if [ ! -d "text-generation-webui" ]; then
  git clone https://github.com/oobabooga/text-generation-webui.git --depth 1 --single-branch
fi

cp CMD_FLAGS.txt text-generation-webui/CMD_FLAGS.txt

cd text-generation-webui
cp docker/nvidia/Dockerfile Dockerfile
docker build -t registry.home.ryougi.ca/tgwu .
docker push registry.home.ryougi.ca/tgwu
