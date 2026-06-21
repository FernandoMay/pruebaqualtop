# Qualtop Test — Cross-Platform Swift App

Cross-platform Swift application for macOS and iOS. Built with SwiftUI for shared code between Apple platforms.

## Structure
```
qualtop/
├── Shared/          # Shared Swift code
├── macOS/           # macOS-specific
├── Tests iOS/       # iOS unit tests
├── Tests macOS/     # macOS unit tests
└── qualtop.xcodeproj/
```

## Requirements
- Xcode 14+
- macOS 12+ / iOS 15+

## Build
```bash
open qualtop.xcodeproj
# Select target (iOS or macOS) → Build & Run
```
