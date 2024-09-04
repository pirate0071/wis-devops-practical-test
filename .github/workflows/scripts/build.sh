#!/bin/bash

# Navigate to the theme directory (adjust the path as necessary)
cd ./wp-content/themes/twentytwentyfour

# Install Node.js dependencies
npm install 
# Run Gulp tasks to compile SCSS and JS
npx gulp styles
npx gulp scripts