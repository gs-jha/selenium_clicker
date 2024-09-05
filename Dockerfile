FROM python:3.9-slim

# Install necessary dependencies for Chrome and ChromeDriver
RUN apt-get update && apt-get install -y \
  wget \
  curl \
  unzip \
  xvfb \
  gnupg \
  libnss3 \
  libgconf-2-4 \
  libxss1 \
  fonts-liberation \
  libappindicator3-1 \
  libx11-xcb1 \
  libxcb1 \
  libxcomposite1 \
  libxcursor1 \
  libxi6 \
  libxtst6 \
  libxrandr2 \
  libasound2 \
  libpangocairo-1.0-0 \
  libatk1.0-0 \
  libcups2 \
  --no-install-recommends

# Install Chrome browser
RUN wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | apt-key add - \
  && echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list \
  && apt-get update && apt-get install -y \
  google-chrome-stable \
  --no-install-recommends \
  && rm -rf /var/lib/apt/lists/*

# Install ChromeDriver
RUN CHROME_DRIVER_VERSION=128.0.6613.119 && \
  wget -O /tmp/chromedriver.zip https://storage.googleapis.com/chrome-for-testing-public/$CHROME_DRIVER_VERSION/linux64/chromedriver-linux64.zip && \
  unzip /tmp/chromedriver.zip -d /usr/local/bin/ && \
  rm /tmp/chromedriver.zip && \
  chmod +x /usr/local/bin/chromedriver-linux64/chromedriver

# Install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

WORKDIR /app

# Copy the Python script
COPY ./app/app.py /app

# Set environment variables for ChromeDriver
ENV DISPLAY=:99

# Run the Python script as the container entrypoint
ENTRYPOINT ["python", "/app/app.py"]
