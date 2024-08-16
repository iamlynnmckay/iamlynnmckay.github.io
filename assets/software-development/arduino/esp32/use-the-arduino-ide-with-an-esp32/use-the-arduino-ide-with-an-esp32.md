# How to Use The Arduino IDE with an ESP32

## Step 1: Install the Arduino IDE
If you don't have the Arduino IDE installed, download it from the [Arduino website](https://www.arduino.cc/en/software) and install it on your computer.

## Step 2: Add ESP32 Board to Arduino IDE
1. **Open the Arduino IDE**.
2. **Go to Preferences**:
   - On Windows: `File -> Preferences`
   - On macOS: `Arduino -> Preferences`
3. **Add ESP32 URL to Additional Board Manager URLs**:
   - In the "Additional Board Manager URLs" field, add the following URL:
     ```
     https://dl.espressif.com/dl/package_esp32_index.json
     ```
   - If there are already URLs in the field, separate them with a comma.

4. **Open the Boards Manager**:
   - Go to `Tools -> Board -> Boards Manager`.
5. **Install the ESP32 Board**:
   - In the search bar, type "esp32" and install the "esp32" by Espressif Systems.

## Step 3: Select Your ESP32 Board
1. **Go to `Tools -> Board -> ESP32 Arduino`**.
2. **Select your ESP32 board** from the list. For example, select "ESP32 Dev Module" if you are using a generic ESP32 development board.

## Step 4: Select the Correct Port
1. **Connect your ESP32 board** to your computer using a USB cable.
2. **Go to `Tools -> Port`** and select the port to which your ESP32 is connected.

## Step 5: Write and Upload Code
Now you can write your code in the Arduino IDE and upload it to the ESP32.

## Example Code for ESP32
Here is an example code that connects to a WiFi network and blinks an LED connected to GPIO 2:

```cpp
{% embed from='./simple_esp32_wifi_example/simple_esp32_wifi_example.ino' raw=true %}
```