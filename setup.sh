#!/bin/bash

# generate_project.sh
# Generate the Xcode project
xcodegen generate

# Install CocoaPods dependencies
pod install