// Replace with your network credentials
#include <WiFi.h>
#include <WiFiUdp.h>
#include <Adafruit_NeoPixel.h>

// Replace with your network credentials
const char* ssid = "your_SSID";
const char* password = "your_PASSWORD";

// Set your ESP32 hostname
const char* hostname = "your_HOSTNAME";

// Number of LEDs in the strip
const int numLEDs = 60;
const int bufferSize = 1024;
const int timeout = 1000; // Timeout in milliseconds

// GPIO pin where the LED strip is connected
const int ledPin = 5;

// UDP settings
WiFiUDP udp;
const unsigned int localUdpPort = 12345;  // Local port to listen on

// Initialize the LED strip
Adafruit_NeoPixel strip = Adafruit_NeoPixel(numLEDs, ledPin, NEO_GRB + NEO_KHZ800);

void setup() {
  Serial.begin(115200);

  // Connect to Wi-Fi network
  Serial.println("Connecting to WiFi...");
  WiFi.begin(ssid, password);
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
  Serial.println("WiFi connected");
  
  // Set the hostname
  WiFi.setHostname(hostname);

  // Initialize the LED strip
  strip.begin();
  strip.show(); // Initialize all pixels to 'off'

  // Start the UDP server
  udp.begin(localUdpPort);
  Serial.printf("Now listening at IP %s, UDP port %d\n", WiFi.localIP().toString().c_str(), localUdpPort);
}

void loop() {
  // Ensure WiFi is connected
  if (WiFi.status() != WL_CONNECTED) {
    WiFi.begin(ssid, password);
    while (WiFi.status() != WL_CONNECTED) {
      delay(500);
      Serial.print(".");
    }
    Serial.println("Reconnected to WiFi");
  }

  Serial.printf("Listening for bytes at IP %s, UDP port %d\n", WiFi.localIP().toString().c_str(), localUdpPort);
  // Buffer to store incoming bytes
  byte buffer[bufferSize];
  int packetSize = udp.parsePacket();
  if (packetSize) {
    int len = udp.read(buffer, bufferSize);
    if (len > 0) {
      buffer[len] = 0;
    }
    Serial.printf("Received %d bytes from %s, port %d\n", len, udp.remoteIP().toString().c_str(), udp.remotePort());
    Serial.printf("UDP packet contents: %s\n", buffer);

    // Process bytes in groups of 8
    for (int i = 0; i < len; i += 8) {
      if (i + 8 <= len) {
        processBytes(buffer + i);
      }
    }
  } else {
    Serial.println("No bytes recieved");
    strip.show(); // Initialize all pixels to 'off'
  }

  // Repeat
}

void processBytes(byte* data) {
  // Example processing function
  // Implement your own processing logic here
  uint32_t color = strip.Color(data[0], data[1], data[2]); // Assuming RGB values
  int ledIndex = data[3]; // Assuming the LED index is specified in data[3]
  strip.setPixelColor(ledIndex, color);
  strip.show();

  // Wait for the specified amount of time in milliseconds
  int waitTime = data[4];
  delay(waitTime);
}
