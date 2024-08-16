# Decrypt an Encrypted String on an ESP32 Using Its MAC Address

## Introduction
To decrypt an encrypted string using the MAC address on an ESP32, you can use the `mbedtls` library included in the ESP-IDF framework. This guide demonstrates how to derive an AES key from the MAC address and decrypt a message using AES encryption.

## Python Script to Generate Ciphertext

To generate the actual ciphertext that you can then decrypt with the ESP32, use the following Python script. This script will:
1. Derive an AES key from the MAC address.
2. Encrypt a message using AES encryption.
3. Base64 encode the ciphertext and IV for easy transfer.

```python
{% embed from='./encrypt_using_mac_address_on_localhost.py' raw=true %}
```

## C Code on ESP32 for Decryption

The following C code for the ESP32 demonstrates how to:
1. Derive an AES key from the MAC address.
2. Decrypt the ciphertext using the derived key.
3. Base64 decode the ciphertext, IV, and salt received from the Python script.

### Explanation

1. **derive_key_from_mac function**: Updated to include the salt in the key derivation.
2. **app_main function**:
   - Retrieves the MAC address of the ESP32.
   - Decodes the Base64 encoded IV, salt, and ciphertext.
   - Derives the AES key using the MAC address and salt.
   - Decrypts the ciphertext and prints the decrypted message.

Replace the placeholder values (e.g., `Base64EncodedCiphertext`, `Base64EncodedIV`, `Base64EncodedSalt`) with your actual encrypted data when using this in a real application. The derived key and IV must match those used during the encryption process.


### C Code

```c
{% embed from='./decrypt_using_mac_address_on_esp32/decrypt_using_mac_address_on_esp32.ino' raw=true %}
```