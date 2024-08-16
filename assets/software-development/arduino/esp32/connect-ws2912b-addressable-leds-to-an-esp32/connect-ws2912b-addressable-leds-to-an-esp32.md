# Connect WS2912b Addressable LEDs to an ESP32

## Introduction
This guide demonstrates how to connect and control a WS2812B addressable LED strip using an ESP32. The ESP32 will be connected to a WiFi network and will process incoming data to control the LEDs.

## Materials Needed
- ESP32 development board
- WS2812B LED strip
- Power supply (5V recommended)
- Capacitor (1000 µF, 6.3V or higher)
- Resistor (330 Ω)
- Breadboard and jumper wires (optional)

## Connections

1. **Power Supply**:
   - **VCC**: Connect the VCC pin of the LED strip to the 5V power supply. It's important to use an external power supply if you're using more than a few LEDs, as the ESP32's 5V pin might not supply enough current.
   - **GND**: Connect the GND pin of the LED strip to the ground of the power supply and the ground pin of the ESP32 to ensure a common ground.

2. **Data Line**:
   - **DIN**: Connect the data input (DIN) pin of the LED strip to one of the GPIO pins on the ESP32. A 330 Ω resistor is recommended between the GPIO pin and the DIN pin to limit current spikes.
   - **Capacitor**: Place a 1000 µF capacitor between VCC and GND of the LED strip to smooth out power supply fluctuations.

## Wiring Diagram

Here's a simple wiring diagram:

{% embed from='./wiring_diagram.txt' raw=true %}

- `[C]` is the capacitor (1000 µF, 6.3V or higher)
- `[R]` is the resistor (330 Ω)
- `GPIO_PIN` is the GPIO pin on the ESP32 (e.g., GPIO 5)

## Steps

1. **Power off the ESP32** and the power supply before making connections.
2. **Connect the VCC and GND** of the LED strip to the power supply and the ESP32 GND.
3. **Place a 1000 µF capacitor** between VCC and GND of the LED strip.
4. **Connect a 330 Ω resistor** between the ESP32 GPIO pin and the DIN pin of the LED strip.
5. **Double-check all connections** to ensure they are secure and correct.
6. **Power on the power supply** and then the ESP32.

## Example Code to Test the LEDs

Use example code to test the connection. This code will light up the first LED in red, green, and blue in sequence.

```c
{% embed from='./simple_esp32_led_example/simple_esp32_led_example.ino' raw=true %}
```

## Tips

- Ensure the power supply can provide enough current for the number of LEDs you are using. Each WS2812B LED can draw up to 60mA at full brightness (white color).
- Avoid using long wires between the ESP32 and the LED strip to prevent signal degradation. If you need to use long wires, consider using a level shifter to boost the data signal from 3.3V to 5V.

By following these steps, you can successfully connect and control a WS2812B addressable LED strip with your ESP32.
