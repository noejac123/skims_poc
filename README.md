# skims_poc

A Proof of Concept for a Virtual Try On features for the Skims App to showcase my programming experience as well as build a cool idea I had for the app.

## Getting Started

To run this application, you need to have the following:

- Flutter SDK installed
- FVM installed
- Gemini API Key

## Installation
```
fvm use 3.29.2

fvm flutter pub get
```
Ensure there is a .env file in the root directory with the following content:
```
GEMINI_API_KEY=your_gemini_api_key
```

## Running the Application
```
fvm flutter run
```

    
## Future Considerations
- Safety - Gemini API safety settings banning probably more than half of the images from being generated.
- Cost - With nano-banana 2 the cost is about 7 cents per image. 
- Quality - The quality of the images is very dependent on the quality of the user input image. 
