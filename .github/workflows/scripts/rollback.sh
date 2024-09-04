#!/bin/bash
set -e

echo "Rolling back to previous stable release..."
cd /path/to/deploy/
git reset --hard HEAD~1