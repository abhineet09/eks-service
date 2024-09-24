from flask import Flask
import os
import sys
import logging

app = Flask(__name__)

# Configure logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

server_id = os.getenv('SERVER_ID')

@app.route('/')
def hello():
    return f"Hello, World! from Server {server_id}"

if __name__ == '__main__':
    if server_id is None:
        logger.error("Error: SERVER_ID environment variable not found.")
        sys.exit(1)

    logger.info(f"Server {server_id} started")
    app.run(host='0.0.0.0', port=5000)