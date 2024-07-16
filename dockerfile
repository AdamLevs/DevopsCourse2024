# Use the official Python base image with tag 3.9
FROM python:3.9

# Set environment variables
ENV FLASK_APP=flaskr
ENV FLASK_ENV=development
ENV FLASK_RUN_HOST=0.0.0.0
ENV FLASK_RUN_PORT=5000

# Set the working directory in the container
WORKDIR /code

# Copy the current directory contents into the container at /code
COPY . /code

# Install system dependencies
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        gcc \
        libpq-dev \
    && rm -rf /var/lib/apt/lists/*

# Install Flask and Flaskr
RUN pip install -e .

# Expose the Flask port
EXPOSE 5000

# Initialize the database
CMD flask --app flaskr init-db && flask --app flaskr run --host=$FLASK_RUN_HOST --port=$FLASK_RUN_PORT

