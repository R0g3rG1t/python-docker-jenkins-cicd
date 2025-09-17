# Use Python as the base image
FROM python:3.12-slim

# Set the working directory
WORKDIR /app

# Install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the application code
COPY . .

# Expose the port
EXPOSE 5000

# Command to run the Flask app
CMD ["python", "app.py"]

