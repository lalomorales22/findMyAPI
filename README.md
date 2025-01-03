# FindMyAPI
<img width="566" alt="Screenshot 2025-01-03 at 3 17 59 PM" src="https://github.com/user-attachments/assets/9557c021-95f0-4d6e-8491-7322564c795f" />

FindMyAPI is a macOS application designed to help developers securely manage and organize their API keys. Built with SwiftUI and leveraging SwiftData for persistent storage, it provides a clean and intuitive interface for storing, categorizing, and quickly accessing your API keys.

## Features

- **Secure Storage**: Safely store your API keys locally on your machine
- **Categorization**: Organize API keys into custom categories
- **Quick Search**: Easily find your API keys using the search functionality
- **Copy Options**: 
  - Copy just the API key
  - Copy as an export statement (perfect for terminal use)
- **Category Management**: 
  - Create, edit, and delete categories
  - View all API keys or filter by category
- **Intuitive Interface**:
  - Clean, native macOS design
  - Split view navigation
  - Swipe actions for quick category management

## Requirements

- macOS 14.0 or later
- Xcode 15.0 or later (for building from source)

## Installation

### Option 1: Download Release

1. Go to the Releases section of this repository
2. Download the latest version of FindMyAPI
3. Move the app to your Applications folder

### Option 2: Build from Source

1. Clone this repository:
   ```bash
   git clone https://github.com/lalomorales22/findMyAPI.git
   ```
2. Open `FindMyAPI folder` in Xcode
3. Build and run the project (⌘R)

## Usage

1. **Adding Categories**:
   - Click the '+' button in the sidebar to create a new category
   - Enter a name for your category

2. **Adding API Keys**:
   - Click the '+' button in the main window
   - Enter the key name, value, and description
   - Optionally assign it to a category

3. **Managing Keys**:
   - Use the search bar to find specific keys
   - Click 'Copy Key' to copy just the API key
   - Click 'Copy as Export' to copy the key in export format (export KEY=value)

4. **Managing Categories**:
   - Swipe left on a category to edit or delete
   - Right-click on a category for additional options

## Security & Privacy

All API keys are stored locally using SwiftData in your application's container directory, which is isolated from other applications. The app does not transmit any data over the network.

**Important Note**: If you're cloning this repository, any existing API keys in your local database will NOT be included in the git repository. The .gitignore file is configured to exclude all database files and sensitive information.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments

- Built with SwiftUI and SwiftData
- Designed for macOS Sonoma and later
