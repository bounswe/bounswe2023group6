# Use the official Ubuntu 20.04 as the base image
FROM ubuntu:20.04

# Update package lists and install necessary dependencies
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory inside the container
WORKDIR /practice-app

# Copy the requirements file to the container
COPY requirements.txt .

# Install the Python dependencies
RUN pip3 install -r requirements.txt

# Copy the Flask app code to the container
COPY . .

# Expose the port on which the Flask app will run
EXPOSE 5000

ENV FLASK_ENV=docker

# Set the entry point to run the Flask app
CMD [ "flask", "--app", "app/", "run", "--host=0.0.0.0" ]
