FROM python:3.11

# Set the working directory
WORKDIR /app

# Copy app directory
COPY . /app

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Expose the port that the Flask app will run on
EXPOSE 5000

# Command to run the application using Gunicorn WSGI server
ENTRYPOINT ["gunicorn", "--bind", "0.0.0.0:5000", "app:app"]
