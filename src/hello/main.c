#include <limits.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "sodium.h"

/*
 * print_hex() is a wrapper around sodium_bin2hex() which allocates
 * temporary memory then immediately prints the result followed by \n
 */
static void
print_hex(const void *bin, const size_t bin_len)
{
    char   *hex;
    size_t  hex_size;

    if (bin_len >= SIZE_MAX / 2) {
        abort();
    }
    hex_size = bin_len * 2 + 1;
    if ((hex = malloc(hex_size)) == NULL) {
        abort();
    }
    /* the library supplies a few utility functions like the one below */
    if (sodium_bin2hex(hex, hex_size, bin, bin_len) == NULL) {
        abort();
    }
    puts(hex);
    free(hex);
}


int main(int argc, char ** argv) {

    unsigned char key[crypto_generichash_KEYBYTES_MAX];
    unsigned char hash[crypto_generichash_BYTES];
    unsigned char message[1024];
    size_t        message_len;
    size_t        key_len;

    printf("Hello Sodium...\n");

    sodium_init();
    printf("Using libsodium %s\n", sodium_version_string());

    puts("Example: crypto_generichash()\n\n");

    strcpy(key, "_key_");
    key_len = strlen(key);
    printf("Key: %s\n", key);

    strcpy(message, "_sample_message_");
    message_len = strlen(message);
    printf("Message: %s\n", message);

    printf("Hashing message with: %s\n\n", crypto_generichash_primitive());

    if (crypto_generichash(hash, sizeof hash, message, message_len,
                           key, key_len) != 0) {
        puts("Couldn't hash the message, probably due to the key length");
    } else {
        printf("Hash: ");
        print_hex(hash, sizeof hash);
    }

    return 0;
}
