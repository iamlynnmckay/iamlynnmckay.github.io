import socket
import random
import time

# Constants
ESP32_IP = '10.0.0.1'  # Replace with the actual IP address of your ESP32
ESP32_PORT = 12345  # Port on which ESP32 is listening

def send_data_to_esp32(data):
    sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    sock.sendto(data, (ESP32_IP, ESP32_PORT))

def generate_random_color(begin, end):
    # Generate a random color
    r = random.randint(begin, end)
    g = random.randint(begin, end)
    b = random.randint(begin, end)
    return r, g, b

def main():
    count = 0
    while True:
        # Counter for brightness
        count = count + 10
        led_indices = list(range(64))
        random.shuffle(led_indices)
        for led_index in led_indices:
            # Generate random color with increasing brightness
            r, g, b = generate_random_color(0, count % 128)
            wait_time = 10  # Example wait time in milliseconds
            data = bytearray([r, g, b, led_index, wait_time, 0, 0, 0])
            send_data_to_esp32(data)
            time.sleep(0.01)  # Sleep for 100 milliseconds

if __name__ == "__main__":
    main()
