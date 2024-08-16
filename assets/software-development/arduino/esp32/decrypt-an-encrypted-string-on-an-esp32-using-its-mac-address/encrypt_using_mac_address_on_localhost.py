from cryptography.hazmat.primitives.kdf.pbkdf2 import PBKDF2HMAC
from cryptography.hazmat.primitives import hashes
from cryptography.hazmat.primitives.ciphers import Cipher, algorithms, modes
from cryptography.hazmat.backends import default_backend
from base64 import urlsafe_b64encode, urlsafe_b64decode
import os

# Replace with the MAC address of your ESP32
mac_address = "30:AE:A4:32:12:34"

# Convert the MAC address to a bytes object
mac_bytes = mac_address.replace(":", "").encode('utf-8')

# Derive a key from the MAC address using PBKDF2
salt = os.urandom(16)  # This should be stored and reused for decryption
kdf = PBKDF2HMAC(
    algorithm=hashes.SHA256(),
    length=32,
    salt=salt,
    iterations=100000,
    backend=default_backend()
)
key = kdf.derive(mac_bytes)

def encrypt(message, key):
    iv = os.urandom(16)
    cipher = Cipher(algorithms.AES(key), modes.CFB(iv), backend=default_backend())
    encryptor = cipher.encryptor()
    ct = encryptor.update(message.encode('utf-8')) + encryptor.finalize()
    return urlsafe_b64encode(iv + ct).decode('utf-8'), urlsafe_b64encode(iv).decode('utf-8')

# Example message
message = "This is a secret message"

# Encrypt the message
ciphertext, iv = encrypt(message, key)
print("Ciphertext:", ciphertext)
print("IV:", iv)
print("Salt:", urlsafe_b64encode(salt).decode('utf-8'))

# Example output
# Ciphertext: WysbFpJW... (actual base64 encoded ciphertext)
# IV: C25qUk8B... (actual base64 encoded IV)
# Salt: GmtR1mks... (actual base64 encoded salt)