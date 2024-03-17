IMAGE_NAME="atimis224/my-demo-app"  # Replace with your actual image name
VERSION_PREFIX="v1.0-"             # Replace with your versioning prefix

# Get a list of all images matching the pattern
IMAGES=$(docker images --filter reference="$IMAGE_NAME:$VERSION_PREFIX*" --format "{{.ID}}")

# Remove all listed images (use with caution)
for image_id in $IMAGES; do
          echo "Removing image: $image_id"
            docker rmi "$image_id" --force
    done

    # Your existing Docker image build commands here
    # ...