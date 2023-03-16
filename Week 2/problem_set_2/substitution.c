#include <cs50.h>
#include <stdio.h>
#include <string.h>
#include <ctype.h>

int main(int argc, string argv[])
{
    if (argc != 2)
    {
        printf("Usage: ./substitution key\n");
        return 1;
    }

    string key = argv[1];

    for (int i = 0; i < strlen(key); i++)
    {
        if (!isalpha(key[i]))
        {
          printf("Usage: ./substitution key\n");
          return 1;
        }
    }

    //Check that the key array has a length of 26
    if (strlen(key) != 26)
    {
        printf("The key must contain 26 characters \n");
        return 1;
    }

    //Check that each character of the key is unique
    for (int i = 0; i < strlen(key); i++)
    {
        for (int j = i + 1; j < strlen(key); j++)
        {
            if (toupper(key[i]) == toupper(key[j]))
            {
                printf("Usage: ./substitution key\n");
                return 1;
            }
        }
    }

    string text = get_string("plaintext: ");

    for (int i = 0; i < strlen(key); i++)
    {
        if (islower(key[i]))
        {
            key[i] = key[i] - 32;
        }
    }

    printf("ciphertext: ");

    for (int i = 0; i < strlen(text); i++)
    {
        if (isupper(text[i]))
        {
            int letter = text[i] - 65;
            printf("%c", key[letter]);
        }
        else if (islower(text[i]))
        {
            int letter = text[i] - 97;
            printf("%c", tolower(key[letter]));
        }
        else
        {
            printf("%c", text[i]);
        }
    }
    printf("\n");
}