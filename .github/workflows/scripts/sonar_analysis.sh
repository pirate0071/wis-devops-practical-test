#!/bin/bash
set -e

# Check if sonar-scanner is already installed
if command -v sonar-scanner >/dev/null 2>&1; then
  echo "SonarScanner is already installed."
else
  echo "SonarScanner is not installed. Installing SonarScanner..."

  # Download SonarScanner
  curl -sSLo sonar-scanner.zip "https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-${SONAR_SCANNER_VERSION}-linux.zip"

  # Unzip the package
  unzip sonar-scanner.zip

  # Move SonarScanner to the installation directory
  sudo mv "sonar-scanner-${SONAR_SCANNER_VERSION}-linux" "$INSTALL_DIR/sonar-scanner"

  # Add sonar-scanner to the PATH
  export PATH="$INSTALL_DIR/sonar-scanner/bin:$PATH"

  # Clean up the downloaded files
  rm sonar-scanner.zip

  echo "SonarScanner version $SONAR_SCANNER_VERSION installed successfully."
fi

# Check if sonar-scanner is now available
if ! command -v sonar-scanner >/dev/null 2>&1; then
  echo "Error: SonarScanner installation failed."
  exit 1
fi

# Check if required environment variables are set
if [ -z "$SONAR_PROJECT_KEY" ]; then
  echo "Error: SONAR_PROJECT_KEY is not set."
  exit 1
fi

if [ -z "$SONAR_ORGANIZATION" ]; then
  echo "Error: SONAR_ORGANIZATION is not set."
  exit 1
fi

if [ -z "$SONAR_HOST_URL" ]; then
  echo "Error: SONAR_HOST_URL is not set."
  exit 1
fi

if [ -z "$SONAR_TOKEN" ]; then
  echo "Error: SONAR_TOKEN is not set."
  exit 1
fi

# Run SonarScanner
sonar-scanner \
  -Dsonar.projectKey="$SONAR_PROJECT_KEY" \
  -Dsonar.organization="$SONAR_ORGANIZATION" \
  -Dsonar.host.url="$SONAR_HOST_URL" \
  -Dsonar.login="$SONAR_TOKEN"