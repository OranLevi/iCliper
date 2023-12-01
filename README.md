
# iCliper

iCliper is a straightforward and efficient clipboard management app for iOS. Built using SwiftUI and following the MVVM architecture, it empowers users to effortlessly copy, paste, and manage their clipboard history, thereby enhancing productivity and convenience. it build with SwiftData for storage data and provides a custom keyboard extension for quick access to clipboard history.

## Features

- Clipboard History: Keep track of your copied items in a history list.
- Search Functionality: Quickly find and access previous clipboard entries.
- Intuitive User Interface: A user-friendly design ensures a seamless and pleasant experience.
- Dark Mode Support: iCliper seamlessly toggles between light and dark modes.

## Screenshots

[[Screenshots1]](https://github.com/OranLevi/iCliper/blob/main/Screenshots/Screenshot1.jpg?raw=true) , [[Screenshots2]](https://github.com/OranLevi/iCliper/blob/main/Screenshots/Screenshot2.jpg?raw=true) , [[Screenshots3]](https://github.com/OranLevi/iCliper/blob/main/Screenshots/Screenshot3.jpg?raw=true)

## Architecture

iCliper follows the MVVM (Model-View-ViewModel) architectural pattern. Here's a brief explanation of the different components:

**Model**: Contains the data models used in the app.<br>
**View**: Defines the user interface components and their layout using SwiftUI.<br>
**ViewModel**: Acts as an intermediary between the View and Model, providing data and handling user interactions.<br>

## Folder Structure

The project is organized as follows:

**Models**: Contains the data models used in the app.<br>
**Views**: Contains the SwiftUI view files.<br>
**ViewModels**: Contains the ViewModel files.<br>
**Services**: Contains the SwiftDataManager code responsible for fetching and providing data to the iCliper app..<br>
**Extensions**: Contains Swift extensions that add extra functionality to existing classes or types.

## Getting Started

To get started with iCliper, follow the instructions below:

1. Clone the repository:

```sh
git clone https://github.com/OranLevi/iCliper.git
```
2. Open the iCliper.xcodeproj file in Xcode.

Build and run the app in the Xcode simulator or on a physical device.

## Contact
Contributions are always welcome! If you have any ideas for features, bug fixes, or other improvements, please submit a pull request.
