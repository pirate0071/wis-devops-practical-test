#!/bin/bash
# ==============================================================================
# Web International Services (WIS):
# ==============================================================================
# *       *       *    *       *   *       *       *
# * *   * *     *    *   *   *   *   *   *   *   *   *
# *   * *   *   *      *   *   *   *     *   *     *   *
# *   * *   *   *      *   *   *   *     *   *     *   *
# *   * *   *   *      *   *   *   *     *   *     *   *
# *   * *   *   *      *   *   *   *     *   *     *   *
# *   * *   *   *      *   *   *   *     *   *     *   *
# ==============================================================================
# Script Version: 1.0
# Last Updated: [04/09/2024]
# Author: [Montassar SMIDA]
# ==============================================================================

# Navigate to the theme directory (adjust the path as necessary)
cd ./wp-content/themes/twentytwentyfour

# Install Node.js dependencies
npm install 
# Run Gulp tasks to compile SCSS and JS
npx gulp styles
npx gulp scripts