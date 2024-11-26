<?php
// This file contains utility functions that are used by other files.

/**
 * Encrypts the given data using AES-256-CBC encryption algorithm.
 *
 * @param string $data The data to be encrypted.
 * @param string $key The encryption key.
 * @return string|false The encrypted data or false on failure.
 */
function encrypt(string $data, string $key) {
    $iv = openssl_random_pseudo_bytes(openssl_cipher_iv_length('aes-256-cbc'));
    $encrypted = openssl_encrypt($data, 'aes-256-cbc', $key, 0, $iv);
    return $encrypted;
}

/**
 * Decrypts the given data using AES-256-CBC encryption algorithm.
 *
 * @param string $data The data to be decrypted.
 * @param string $key The encryption key.
 * @return string|false The decrypted data or false on failure.
 */
function decrypt($data, $key) {
    $iv = openssl_random_pseudo_bytes(openssl_cipher_iv_length('aes-256-cbc'));
    $decrypted = openssl_decrypt($data, 'aes-256-cbc', $key, 0, $iv);
    return $decrypted;
}