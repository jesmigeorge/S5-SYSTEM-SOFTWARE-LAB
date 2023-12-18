#include <stdio.h>
#include <stdlib.h>
#include <string.h>
void main()
{
    FILE *f1=fopen("input.txt","r");
    char in[20];
    int start,length;
    fscanf(f1,"%s",in);
    printf("ADDRESS\tCONTENT\n");
    while (strcmp(in,"E")!=0)
    {
        if (strcmp(in,"T")==0)
        {
            fscanf(f1,"%x %x %s",&start,&length,in);
            while (strcmp(in,"T")!=0 && strcmp(in,"E")!=0)
            {
                for(int i=0;i<strlen(in);i+=2){
                    printf("%x\t%c%c\n",start,in[i],in[i+1]);
                    start+=1;
                }
                fscanf(f1,"%s",in);
            }
        }
        else
            fscanf(f1,"%s",in);
    }
}