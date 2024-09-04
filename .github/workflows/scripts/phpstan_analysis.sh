#!/bin/bash
set -e

echo "Installing PHPStan..."
composer require --dev phpstan/phpstan

echo "Running PHPStan analysis..."
./vendor/bin/phpstan analyse src