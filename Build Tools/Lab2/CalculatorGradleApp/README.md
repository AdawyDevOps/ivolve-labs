# Lab 2: Gradle Calculator Application

## Objective
Install Gradle, clone a Java calculator application, run unit tests,
build the application, generate a JAR artifact, and verify that it works.

## Tools and Technologies
- Ubuntu on WSL
- Java JDK 17
- Gradle
- JUnit 5
- Git

## Source Code
[CalculatorGradleApp](https://github.com/Ibrahim-Adel15/CalculatorGradleApp)

## Implementation Steps

### 1. Install and Verify Gradle
Verified the Gradle installation using:

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

**Result:** BUILD SUCCESSFUL.

### 4. Build the Application
```bash
gradle build
```

**Result:** BUILD SUCCESSFUL.

### 5. Verify the JAR Artifact
```bash
ls -lh build/libs/calculator.jar
```

**Artifact:** `build/libs/calculator.jar`

### 6. Run the Application
```bash
java -jar build/libs/calculator.jar
```

## Verification Results

Tested the calculator with the following inputs:

- First number: 20
- Second number: 20

| Operation | Expected Result | Actual Result |
|---|---:|---:|
| Addition | 40 | 40.0 |
| Subtraction | 0 | 0.0 |
| Multiplication | 400 | 400.0 |
| Division | 1 | 1.0 |

**Status:** All four arithmetic operations returned the expected results.

## Screenshots

Screenshots are available in the `screenshots/` directory:

1. `01-gradle-version.png` — Gradle installation.
2. `02-unit-tests.png` — Successful unit tests.
3. `03-build-artifact.png` — Successful build and generated JAR.
4. `04-app-running.png` — Calculator execution and results.
