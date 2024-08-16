# Control WS2812B Addressable LEDs with ESP32

## Introduction

This guide demonstrates how to set up UDP communication between an ESP32 and a Python script. The ESP32 will act as a UDP server to receive data and control WS2812B addressable LEDs, while the Python script will act as a UDP client to send data to the ESP32.

## Step-by-Step Guide to Set Up UDP Server on ESP32

### Include necessary libraries
Include the required WiFi and UDP libraries.

### Define network credentials and port
Define your WiFi credentials and the UDP port that you want the ESP32 to listen on.

### Initialize WiFi and UDP
Set up the WiFi connection and initialize the UDP server to listen on the specified port.

### Receive and process UDP packets
In the main loop, check for incoming UDP packets and process them accordingly.

```c
{% embed from='./server_on_esp32/server_on_esp32.ino' raw=true %}
```

### Explanation

1. **WiFi Setup**: Connects the ESP32 to the specified WiFi network and sets the hostname.
2. **UDP Initialization**: Starts the UDP server to listen on the specified local port (`localUdpPort`).
3. **Packet Reception and Processing**: In the loop, checks for incoming UDP packets, reads the data into a buffer, and processes the data in groups of 8 bytes.
4. **LED Control**: Uses the received data to set the color of the WS2812B LEDs and waits for a specified time before processing the next set of data.

### Finding the ESP32 IP Address

To find the IP address of your ESP32, you can use a snippet within the `setup` function that prints the IP address to the serial monitor once the ESP32 is connected to the WiFi.

```c
Serial.println(WiFi.localIP());
```

## Python Script to Send Data to ESP32

Ensure your Python script uses the correct IP address of the ESP32.

```c
{% embed from='./client_on_localhost.py' raw=true %}
```

### Explanation

1. **Constants**: Define the ESP32 IP address and the port on which the ESP32 is listening.
2. **send_data_to_esp32 function**: Sends the specified data to the ESP32 using a UDP socket.
3. **generate_random_color function**: Generates a random color with low brightness by limiting the RGB values to a range of 0 to 64.
4. **main function**: Iterates over the first 5 LEDs, generates a random color for each LED, prepares the data, and sends it to the ESP32.

Replace the `ESP32_IP` with the actual IP address of your ESP32 and ensure the port matches the one set in the ESP32 code (`ESP32_PORT`). This script will set each of the first 5 LEDs to a random color with low brightness and send the data to the ESP32.
