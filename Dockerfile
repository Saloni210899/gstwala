FROM python:3.12.3
 
# Step 2: Set the working directory inside the container
WORKDIR /app
 
# Step 3: Copy the project files to the container
COPY . .
 
# Step 4: Install the dependencies
RUN pip install -r requirements.txt
RUN  python manage.py makemigrations
RUN  python manage.py migrate

# Step 5: Expose the port on which the app runs
EXPOSE 8000
 
# Step 6: Start the Django app
CMD ["python", "manage.py", "runserver"]
 
 
