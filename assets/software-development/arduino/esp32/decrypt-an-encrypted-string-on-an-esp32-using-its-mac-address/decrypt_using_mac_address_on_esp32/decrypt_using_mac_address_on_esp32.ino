#include <stdio.h>
#include <string.h>
#include "freertos/FreeRTOS.h"
#include "freertos/task.h"
#include "esp_system.h"
#include "esp_wifi.h"
#include "esp_log.h"
#include "mbedtls/aes.h"
#include "mbedtls/md.h"
#include "mbedtls/base64.h"

#define AES_KEYLEN 32
#define AES_IVLEN 16
#define SALT_LEN 16

static const char *TAG = "AES_DECRYPT";

void derive_key_from_mac(const uint8_t *mac, const uint8_t *salt, uint8_t *key) {
    mbedtls_md_context_t ctx;
    mbedtls_md_type_t md_type = MBEDTLS_MD_SHA256;

    mbedtls_md_init(&ctx);
    mbedtls_md_setup(&ctx, mbedtls_md_info_from_type(md_type), 1);
    mbedtls_md_starts(&ctx);
    mbedtls_md_update(&ctx, mac, 6); // MAC address length is 6 bytes
    mbedtls_md_update(&ctx, salt, SALT_LEN); // Use the same salt for key derivation
    mbedtls_md_finish(&ctx, key);
    mbedtls_md_free(&ctx);
}

void decrypt_message(const uint8_t *key, const uint8_t *iv, const uint8_t *ciphertext, size_t ciphertext_len, uint8_t *plaintext) {
    mbedtls_aes_context aes;
    mbedtls_aes_init(&aes);

    mbedtls_aes_setkey_dec(&aes, key, AES_KEYLEN * 8);
    mbedtls_aes_crypt_cfb128(&aes, MBEDTLS_AES_DECRYPT, ciphertext_len, iv, ciphertext, plaintext);

    mbedtls_aes_free(&aes);
}

void app_main(void) {
    uint8_t mac[6];
    uint8_t key[AES_KEYLEN];
    uint8_t iv[AES_IVLEN];
    uint8_t salt[SALT_LEN];
    uint8_t ciphertext[128];
    uint8_t plaintext[128];
    size_t ciphertext_len;

    // Get the MAC address of the ESP32
    esp_wifi_get_mac(ESP_IF_WIFI_STA, mac);
    ESP_LOGI(TAG, "MAC Address: %02x:%02x:%02x:%02x:%02x:%02x", mac[0], mac[1], mac[2], mac[3], mac[4], mac[5]);

    // Base64 encoded values (replace with actual values from Python script)
    const char *base64_ciphertext = "Base64EncodedCiphertext";
    const char *base64_iv = "Base64EncodedIV";
    const char *base64_salt = "Base64EncodedSalt";

    // Decode Base64 values
    size_t iv_len, salt_len;
    mbedtls_base64_decode(iv, sizeof(iv), &iv_len, (const unsigned char *)base64_iv, strlen(base64_iv));
    mbedtls_base64_decode(salt, sizeof(salt), &salt_len, (const unsigned char *)base64_salt, strlen(base64_salt));
    mbedtls_base64_decode(ciphertext, sizeof(ciphertext), &ciphertext_len, (const unsigned char *)base64_ciphertext, strlen(base64_ciphertext));

    // Derive the key from the MAC address and salt
    derive_key_from_mac(mac, salt, key);

    // Decrypt the message
    decrypt_message(key, iv, ciphertext, ciphertext_len, plaintext);

    // Null terminate the decrypted plaintext
    plaintext[ciphertext_len] = '\0';

    ESP_LOGI(TAG, "Decrypted message: %s", plaintext);
}