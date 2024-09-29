# FROM python:3.12.3
 
# # Step 2: Set the working directory inside the container
# WORKDIR /app
 
# # Step 3: Copy the project files to the container
# COPY . .
 
# # Step 4: Install the dependencies
# RUN pip install -r requirements.txt
# RUN  source env/scripts/activate
# RUN  python manage.py makemigrations
# RUN  python manage.py migrate

# # Step 5: Expose the port on which the app runs
# EXPOSE 8000
 
# # Step 6: Start the Django app
# CMD ["python", "manage.py", "runserver"]


## --- D2 ----##
# # Use a specific Python base image
# FROM python:3.12.3

# # Set the working directory
# WORKDIR /app

# # Copy requirements.txt first to leverage Docker caching
# COPY requirements.txt .

# # Update package list
# RUN apt-get update && echo "Updated package list"

# # Install system dependencies
# RUN apt-get install -y --no-install-recommends gcc libpq-dev && echo "Installed system dependencies"

# # Upgrade pip
# RUN pip install --upgrade pip && echo "Upgraded pip"

# # Install Python packages
# RUN pip install -r requirements.txt && echo "Installed Python packages"

# # Copy the rest of your application code
# COPY . .

# # Command to run the application (adjust as needed)
# CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
## ---- D2 ---- ##

# Use a specific Python base image
FROM python:3.12.3

# Set the working directory
WORKDIR /app

# Copy requirements.txt first to leverage Docker caching
COPY requirements.txt .

# Update package list
RUN apt-get update && echo "Updated package list"

# Install system dependencies
RUN apt-get install -y --no-install-recommends gcc libpq-dev && echo "Installed system dependencies"

# Upgrade pip
RUN pip install --upgrade pip && echo "Upgraded pip"

# Install Python packages
RUN pip install -r requirements.txt && echo "Installed Python packages"

# Copy the rest of your application code
COPY . .

# Create a virtual environment
RUN python -m venv env && echo "Created virtual environment"

# Activate the virtual environment and run migrations
RUN . env/Scripts/activate && pip install Django && python manage.py makemigrations && python manage.py migrate

# Command to run the application
CMD ["env/Scripts/python", "manage.py", "runserver", "0.0.0.0:8000"]

