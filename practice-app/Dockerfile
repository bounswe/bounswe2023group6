# Set base image (host OS)
FROM python:3.8-slim-buster

# Set the working directory in the container
WORKDIR /practice-app

# Copy the dependencies file to the working directory
COPY requirements.txt .

# Install any dependencies
RUN pip3 install -r requirements.txt

# Copy the content of the local src directory to the working directory
COPY . .

# Specify the command to run on container start
CMD [ "flask", "--app", "app/", "run", "--host=0.0.0.0" ]