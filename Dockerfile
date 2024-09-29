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

# Use a specific Python base image
FROM python:3.9-slim

# Set the working directory
WORKDIR /app

# Copy requirements.txt first to leverage Docker caching
COPY requirements.txt .

# Install system dependencies and Python packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends gcc libpq-dev && \
    pip install --upgrade pip && \
    pip install -r requirements.txt && \
    apt-get purge -y --auto-remove gcc libpq-dev && \
    rm -rf /var/lib/apt/lists/*

# Copy the rest of your application code
COPY . .

# Command to run the application (adjust as needed)
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]

 
