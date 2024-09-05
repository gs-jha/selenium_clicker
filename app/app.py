from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
import time

# List of URLs
urls = [
    'https://example.com/button1',
    'https://example.com/button2',
    # Add more URLs here
]

# Initialize the WebDriver
options = webdriver.ChromeOptions()
options.add_argument('--headless')  # Run headless if you don't need to see the browser
options.add_argument('--no-sandbox')
options.add_argument('--disable-dev-shm-usage')
options.add_argument("--window-size=1920,1080")
driver = webdriver.Chrome(service=Service('/usr/local/bin/chromedriver-linux64/chromedriver'), options=options)

try:
    for url in urls:
        driver.get(url)
        
        # Click on the first button
        button1 = WebDriverWait(driver, 10).until(
            EC.element_to_be_clickable((By.ID, 'search-blogs'))
        )
        button1.click()
        print(driver.get_screenshot_as_file('/app/blogs_screenshot.png'))
        
        # Wait for 5 seconds
        time.sleep(5)
        
        # Click on the second button
        button2 = WebDriverWait(driver, 10).until(
            EC.element_to_be_clickable((By.ID, 'past-event'))
        )
        button2.click()
        print(driver.get_screenshot_as_file('/app/events_screenshot.png'))
        
        # Optionally, wait a bit before moving to the next URL
        time.sleep(2)

finally:
    driver.quit()
