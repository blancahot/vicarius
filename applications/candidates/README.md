# Candidate Assessment API

This directory contains the application code and tests for the Candidate Assessment API.

## Structure

- `app/` - Main application directory containing the Flask API implementation
- `tests/` - Test suite for the application

## Prerequisites

- **Python**: Ensure you have Python 3.9 or higher installed on your machine.
- **Docker**: If you want to run the application in a container, make sure Docker is installed.
- **pip**: Python's package installer should be available.

## Steps to Run the Application Locally

1. **Clone the Repository**: If you haven't already, clone the repository containing the application code.

   ```bash
   git clone <repository-url>
   cd vicarius/applications/candidates
   ```

2. **Install Dependencies**: Navigate to the `candidates` directory and install the required Python packages.

   ```bash
   pip install -r requirements.txt
   ```

3. **Run the Application**: You can run the Flask application directly using the following command:

   ```bash
   python main.py
   ```

   By default, the application will run on `http://127.0.0.1:5000`.

## Running the Application with Docker

If you prefer to run the application using Docker, follow these steps:

1. **Build the Docker Image**: In the `vicarius/applications/candidates` directory, build the Docker image using the provided Dockerfile.

   ```bash
   docker build -t candidates .
   ```

2. **Run the Docker Container**: After building the image, run the container.

   ```bash
   docker run -p 5000:5000 candidates
   ```

   This will map port 5000 of the container to port 5000 on your host machine.

## Testing the Application

1. **Run Tests**: The application includes a test suite using `unittest`. You can run the tests by executing the following command in the `tests` directory:

   ```bash
   python -m unittest discover tests
   ```

   This will automatically discover and run all test cases defined in the `tests` directory.

2. **Manual Testing**: You can also manually test the API endpoints using tools like `curl` or Postman. Here are some example requests:

   - **Get Candidates**:
     ```bash
     curl -X GET http://127.0.0.1:5000/candidates
     ```

   - **Create a Candidate**:
     ```bash
     curl -X POST http://127.0.0.1:5000/candidates -H "Content-Type: application/json" -d '{"name": "Test User", "email": "test@example.com"}'
     ```
   - **Create an Assesment**:
     ```bash
     curl -X POST http://localhost:5000/candidates/1/assess -H "Content-Type: application/json" -d '{"skill": "Python", "score": 100}'
     ```

  
## Summary

By following these steps, you can run the Candidate Assessment API locally and test its functionality. You can use both direct execution and Docker for running the application, and the provided test suite allows you to verify the correctness of the application.