#!/bin/bash
set -e

echo "Running security scan..."
composer require --dev enlightn/security-checker
./vendor/bin/security-checker security:check