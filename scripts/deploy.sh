#!/bin/bash

# Portfolio Tracker Deployment Script
# This script automates the deployment process

set -e

echo "🚀 Portfolio Tracker Deployment Script"
echo "======================================"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if Flutter is installed
check_flutter() {
    if ! command -v flutter &> /dev/null; then
        print_error "Flutter is not installed or not in PATH"
        exit 1
    fi
    print_status "Flutter is installed"
}

# Check if Firebase CLI is installed
check_firebase() {
    if ! command -v firebase &> /dev/null; then
        print_warning "Firebase CLI not found. Installing..."
        npm install -g firebase-tools
    fi
    print_status "Firebase CLI is available"
}

# Clean and get dependencies
setup_dependencies() {
    print_status "Cleaning project..."
    flutter clean
    
    print_status "Getting dependencies..."
    flutter pub get
    
    print_status "Dependencies installed successfully"
}

# Build Android APK
build_android() {
    print_status "Building Android APK..."
    flutter build apk --release
    
    if [ -f "build/app/outputs/flutter-apk/app-release.apk" ]; then
        print_status "Android APK built successfully"
        print_status "APK location: build/app/outputs/flutter-apk/app-release.apk"
    else
        print_error "Failed to build Android APK"
        exit 1
    fi
}

# Build Android App Bundle
build_app_bundle() {
    print_status "Building Android App Bundle..."
    flutter build appbundle --release
    
    if [ -f "build/app/outputs/bundle/release/app-release.aab" ]; then
        print_status "Android App Bundle built successfully"
        print_status "AAB location: build/app/outputs/bundle/release/app-release.aab"
    else
        print_error "Failed to build Android App Bundle"
        exit 1
    fi
}

# Build iOS
build_ios() {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        print_status "Building iOS app..."
        flutter build ios --release --no-codesign
        
        print_status "iOS build completed"
        print_status "iOS app location: build/ios/iphoneos/Runner.app"
    else
        print_warning "iOS build skipped (not on macOS)"
    fi
}

# Deploy to Firebase
deploy_firebase() {
    print_status "Deploying to Firebase..."
    
    if [ -f "firebase.json" ]; then
        firebase deploy
        print_status "Firebase deployment completed"
    else
        print_warning "firebase.json not found, skipping Firebase deployment"
    fi
}

# Create release
create_release() {
    local version=$1
    if [ -z "$version" ]; then
        version="v1.0.0"
    fi
    
    print_status "Creating release $version..."
    
    # Create git tag
    git tag $version
    git push origin $version
    
    print_status "Release $version created and pushed"
}

# Main deployment function
deploy() {
    local platform=$1
    local version=$2
    
    print_status "Starting deployment process..."
    
    # Setup
    check_flutter
    check_firebase
    setup_dependencies
    
    # Build based on platform
    case $platform in
        "android")
            build_android
            build_app_bundle
            ;;
        "ios")
            build_ios
            ;;
        "all")
            build_android
            build_app_bundle
            build_ios
            ;;
        *)
            print_error "Invalid platform. Use: android, ios, or all"
            exit 1
            ;;
    esac
    
    # Deploy to Firebase
    deploy_firebase
    
    # Create release if version specified
    if [ ! -z "$version" ]; then
        create_release $version
    fi
    
    print_status "Deployment completed successfully! 🎉"
}

# Help function
show_help() {
    echo "Portfolio Tracker Deployment Script"
    echo ""
    echo "Usage: $0 [OPTIONS]"
    echo ""
    echo "Options:"
    echo "  -p, --platform PLATFORM    Platform to build (android, ios, all)"
    echo "  -v, --version VERSION      Version for release (e.g., v1.0.0)"
    echo "  -h, --help                  Show this help message"
    echo ""
    echo "Examples:"
    echo "  $0 --platform android"
    echo "  $0 --platform all --version v1.0.0"
    echo "  $0 --platform ios"
}

# Parse command line arguments
PLATFORM="all"
VERSION=""

while [[ $# -gt 0 ]]; do
    case $1 in
        -p|--platform)
            PLATFORM="$2"
            shift 2
            ;;
        -v|--version)
            VERSION="$2"
            shift 2
            ;;
        -h|--help)
            show_help
            exit 0
            ;;
        *)
            print_error "Unknown option $1"
            show_help
            exit 1
            ;;
    esac
done

# Run deployment
deploy $PLATFORM $VERSION
