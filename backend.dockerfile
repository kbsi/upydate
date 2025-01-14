FROM python:3.10-slim

WORKDIR /app

# Copy Pipfile and Pipfile.lock from src directory
COPY src/Pipfile /app/Pipfile
COPY src/Pipfile.lock /app/Pipfile.lock

# Install pipenv
RUN pip install --no-cache-dir pipenv

# Install dependencies
RUN pipenv install --system --deploy

# Install watchdog
RUN pip install watchdog

# Copy the rest of the application code
COPY src/backend /app/backend
COPY src/library /app/library

# Set environment variables
ENV FLASK_APP=backend/app.py
ENV FLASK_RUN_HOST=0.0.0.0

# Command to run the Flask application
CMD ["flask", "run"]
