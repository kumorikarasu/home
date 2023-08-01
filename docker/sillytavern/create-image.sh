
# Clone the repository
git clone https://github.com/SillyTavern/SillyTavern.git --depth 1 --branch release --single-branch
cd SillyTavern

# Build the image
docker build -t registry.home.ryougi.ca/sillytavern:latest .
docker push registry.home.ryougi.ca/sillytavern:latest

# Cleanup
cd ..
rm -rf SillyTavern
