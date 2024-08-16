#include <Adafruit_NeoPixel.h>

// Pin where the LED strip is connected
#define LED_PIN 5

// Number of LEDs in the strip
#define NUM_LEDS 60

Adafruit_NeoPixel strip = Adafruit_NeoPixel(NUM_LEDS, LED_PIN, NEO_GRB + NEO_KHZ800);

void setup() {
  strip.begin();
  strip.show(); // Initialize all pixels to 'off'
}

void loop() {
  strip.setPixelColor(0, strip.Color(255, 0, 0)); // Red
  strip.show();
  delay(1000);

  strip.setPixelColor(0, strip.Color(0, 255, 0)); // Green
  strip.show();
  delay(1000);

  strip.setPixelColor(0, strip.Color(0, 0, 255)); // Blue
  strip.show();
  delay(1000);
}
