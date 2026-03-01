FROM python:3.12-slim

WORKDIR /app

# Install system dependencies for Playwright
RUN apt-get update && apt-get install -y \
    wget \
    gnupg \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements and install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Install Playwright browsers
RUN playwright install chromium

# Copy application code
COPY mcp_boss.py .

# Create static directory for QR codes
RUN mkdir -p static

# Expose port
EXPOSE 8000

# Run the server
CMD ["python", "mcp_boss.py"]
