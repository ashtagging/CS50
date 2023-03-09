#include <cs50.h>
#include <stdio.h>

int main(void)
{
    int startSize, endSize , years = 0;

    // TODO: Prompt for start size
    do {
        printf("Enter starting population size (min 9)  ");
        scanf("%d", &startSize);
    }
    while(startSize < 9);

    // TODO: Prompt for end size
    do{
        printf("Enter starting population size (min %d)  ", startSize );
        scanf("%d", &endSize);
    }
    while(endSize < startSize);

    // TODO: Calculate number of years until we reach threshold
    while(startSize < endSize)
    {
        startSize = startSize + (startSize/3) - (startSize/4);
        years ++;
    }

    // TODO: Print number of years
    printf("Years: %d\n" , years);
    return 0;
}