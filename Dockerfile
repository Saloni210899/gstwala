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

# Use an appropriate base image
FROM python:3.9

# Set the working directory
WORKDIR /app

# Copy the requirements file and install dependencies
COPY requirements.txt .
RUN pip install -r requirements.txt

# Copy the rest of your application code
COPY . .

# Run migrations directly using the virtual environment's Python
RUN ./env/Scripts/python manage.py makemigrations
RUN ./env/Scripts/python manage.py migrate

# Command to run the application (adjust as needed)
CMD ["./env/Scripts/python", "manage.py", "runserver", "0.0.0.0:8000"]

 
 
