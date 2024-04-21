# Setup Project NotiList Application

Features
List the features of your project:
- Authentication with FirebaseAuth
- My Calendar
- My ToDo List
- My Note


## Installation

```bash
# Clone the repository
git clone https://github.com/tanaphat-time/NotiList.git

# Navigate to the project directory
cd projectname

# Install dependencies
flutter pub get
```
## Usage

Start debugging main.dart in lib folder with your android devices
```bash
void main() async {
  await GetStorage.init();
  runApp(const MyApp());
}
```
