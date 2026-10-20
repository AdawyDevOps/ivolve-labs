# Lab 2: Gradle Calculator Application

## Objective
Install Gradle, clone the Java calculator application, run unit tests,
build the application, generate a JAR artifact, and verify the application.

## Tools
- Ubuntu on WSL
- Java JDK 17
- Gradle
- JUnit 5
- Git

## Source Code
[CalculatorGradleApp](https://github.com/Ibrahim-Adel15/CalculatorGradleApp)

## Steps

### 1. Verify Gradle Installation
```bash
gradle -v
```

### 2. Clone the Repository
```bash
git clone https://github.com/Ibrahim-Adel15/CalculatorGradleApp.git
```

### 3. Run Unit Tests
```bash
gradle test
```
Result: `BUILD SUCCESSFUL`

### 4. Build the Application
```bash
gradle build
```
Result: `BUILD SUCCESSFUL`

### 5. Verify the JAR Artifact
```bash
ls -lh build/libs/calculator.jar
```
Artifact: `build/libs/calculator.jar`

### 6. Run the Application
```bash
java -jar build/libs/calculator.jar
```

## Test Results

Inputs:
- First number: 20
- Second number: 20

| Operation | Expected Result | Actual Result |
|---|---:|---:|
| Addition | 40 | 40.0 |
| Subtraction | 0 | 0.0 |
| Multiplication | 400 | 400.0 |
| Division | 1 | 1.0 |

All four operations returned the expected results.

## Screenshots

- [Unit Tests](screenshots/unit-tests.png)
- [Build Artifact](screenshots/build-artifact.png)
- [Application Execution](screenshots/app-execution.png)
