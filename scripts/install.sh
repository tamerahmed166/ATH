#!/bin/bash

# Portfolio Tracker Installation Script
# This script helps users install the app on their devices

set -e

echo "📱 Portfolio Tracker Installation Script"
echo "========================================"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
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

print_instruction() {
    echo -e "${BLUE}[INSTRUCTION]${NC} $1"
}

# Check if device is connected
check_device() {
    print_status "Checking for connected devices..."
    
    # Check for Android devices
    if command -v adb &> /dev/null; then
        adb devices | grep -q "device$"
        if [ $? -eq 0 ]; then
            print_status "Android device detected"
            return 0
        fi
    fi
    
    # Check for iOS devices
    if command -v flutter &> /dev/null; then
        flutter devices | grep -q "iPhone\|iPad"
        if [ $? -eq 0 ]; then
            print_status "iOS device detected"
            return 0
        fi
    fi
    
    print_warning "No devices detected"
    return 1
}

# Install on Android
install_android() {
    print_status "Installing on Android device..."
    
    if [ -f "build/app/outputs/flutter-apk/app-release.apk" ]; then
        adb install -r build/app/outputs/flutter-apk/app-release.apk
        print_status "Android app installed successfully"
    else
        print_error "APK file not found. Please build the app first."
        exit 1
    fi
}

# Install on iOS
install_ios() {
    print_status "Installing on iOS device..."
    
    if [[ "$OSTYPE" == "darwin"* ]]; then
        flutter install
        print_status "iOS app installed successfully"
    else
        print_error "iOS installation requires macOS"
        exit 1
    fi
}

# Download from GitHub release
download_release() {
    local version=$1
    if [ -z "$version" ]; then
        version="latest"
    fi
    
    print_status "Downloading release $version from GitHub..."
    
    # Get latest release info
    local release_url=$(curl -s "https://api.github.com/repos/yourusername/portfolio-tracker/releases/$version" | grep "browser_download_url.*apk" | cut -d '"' -f 4)
    
    if [ -z "$release_url" ]; then
        print_error "Could not find release $version"
        exit 1
    fi
    
    # Download APK
    print_status "Downloading APK..."
    curl -L -o portfolio-tracker.apk "$release_url"
    
    # Install APK
    if [ -f "portfolio-tracker.apk" ]; then
        adb install portfolio-tracker.apk
        print_status "App installed from GitHub release"
        rm portfolio-tracker.apk
    else
        print_error "Failed to download APK"
        exit 1
    fi
}

# Show installation instructions
show_instructions() {
    echo ""
    print_instruction "Manual Installation Instructions:"
    echo ""
    echo "Android:"
    echo "1. Enable Developer Options on your Android device"
    echo "2. Enable USB Debugging"
    echo "3. Connect device via USB"
    echo "4. Run: adb install app-release.apk"
    echo ""
    echo "iOS:"
    echo "1. Open Xcode"
    echo "2. Open ios/Runner.xcworkspace"
    echo "3. Select your device"
    echo "4. Click Run button"
    echo ""
    echo "GitHub Release:"
    echo "1. Go to: https://github.com/yourusername/portfolio-tracker/releases"
    echo "2. Download the latest APK"
    echo "3. Install on your device"
    echo ""
}

# Main installation function
install() {
    local method=$1
    local version=$2
    
    print_status "Starting installation process..."
    
    case $method in
        "android")
            if check_device; then
                install_android
            else
                show_instructions
            fi
            ;;
        "ios")
            if check_device; then
                install_ios
            else
                show_instructions
            fi
            ;;
        "github")
            download_release $version
            ;;
        "instructions")
            show_instructions
            ;;
        *)
            print_error "Invalid method. Use: android, ios, github, or instructions"
            exit 1
            ;;
    esac
    
    print_status "Installation completed! 🎉"
}

# Help function
show_help() {
    echo "Portfolio Tracker Installation Script"
    echo ""
    echo "Usage: $0 [OPTIONS]"
    echo ""
    echo "Options:"
    echo "  -m, --method METHOD        Installation method (android, ios, github, instructions)"
    echo "  -v, --version VERSION      Version for GitHub download (e.g., v1.0.0)"
    echo "  -h, --help                 Show this help message"
    echo ""
    echo "Examples:"
    echo "  $0 --method android"
    echo "  $0 --method github --version v1.0.0"
    echo "  $0 --method instructions"
}

# Parse command line arguments
METHOD="instructions"
VERSION=""

while [[ $# -gt 0 ]]; do
    case $1 in
        -m|--method)
            METHOD="$2"
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

# Run installation
install $METHOD $VERSION
