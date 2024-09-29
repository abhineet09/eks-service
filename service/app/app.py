from flask import Flask
import os
import sys
import logging
import random

app = Flask(__name__)

# Configure logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

server_id = os.getenv('SERVER_ID')

@app.route('/app')
def hello():
    # Randomly select an upper limit between 10,000 and 10 million
    upper_limit = random.randint(10000, 10000000)
    
    # Increase CPU utilization with a mathematical operation
    result = sum(i * i for i in range(1, upper_limit + 1))

    return f"Hello, World! from App Server {server_id}. Sum of squares up to {upper_limit}: {result}"

@app.route('/')
def healthCheck():
    return ""

if __name__ == '__main__':
    if server_id is None:
        logger.error("Error: SERVER_ID environment variable not found.")
        sys.exit(1)

    logger.info(f"Server {server_id} started")
    app.run(host='0.0.0.0', port=8080)
