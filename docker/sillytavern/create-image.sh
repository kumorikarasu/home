
# Clone the repository
git clone https://github.com/SillyTavern/SillyTavern.git --depth 1 --branch release --single-branch
cp config.yaml SillyTavern/default/config.yaml

# Build the image
cd SillyTavern
docker build -t registry.home.ryougi.ca/st . --no-cache
docker push registry.home.ryougi.ca/st

# Cleanup
cd ..
# rm -rf SillyTavern
