#include <stdio.h>
#include <stdlib.h>
#include <string.h>
char bitmask[12],bit[12];
void convert(char b[])
{
    strcpy(bit,"");
    for(int i=0;i<strlen(b);i++)
    {
        switch(b[i])
        {
            case '0':strcat(bit,"0");
                break;
            case '1':strcat(bit,"1");
                break;
            case '2':strcat(bit,"10");
                break;
            case '3':strcat(bit,"11");
                break;
            case '4':strcat(bit,"100");
                break;
            case '5':strcat(bit,"101");
                break;
            case '6':strcat(bit,"110");
                break;
            case '7':strcat(bit,"111");
                break;
            case '8':strcat(bit,"1000");
                break;
            case '9':strcat(bit,"1001");
                break;
            case 'A':strcat(bit,"1010");
                break;
            case 'B':strcat(bit,"1011");
                break;
            case 'C':strcat(bit,"1100");
                break;
            case 'D':strcat(bit,"1101");
                break;
            case 'E':strcat(bit,"1110");
                break;
            case 'F':strcat(bit,"1111");
                break;
        }
    }
}

void main()
{
    FILE *f1;
    int reloc,start,len,length,opc,addr;
    f1=fopen("input.txt","r");
    char in[50],name[20];
    printf("Enter relocation address : ");
    scanf("%x",&reloc);
    fscanf(f1,"%s",in);
    while (strcmp(in,"E")!=0)
    {
        if (strcmp(in,"H")==0)
        {
            fscanf(f1,"%s %x %x",name,&start,&len);
            printf("H^%-6s^00%x^%x\n",name,reloc,len);
        }
        else if (strcmp(in,"T")==0)
        {
            fscanf(f1,"%x %x %s",&start,&len,bitmask);
            printf("T^00%x^00%x",reloc+start,len);
            convert(bitmask);
            length=strlen(bit);
            if (length>=11)
                length=10;
            for(int i=0;i<length;i++)
            {
                fscanf(f1,"%x %x",&opc,&addr);
                if (bit[i]=='1')
                    addr+=reloc;
                printf("^%x%x",opc,addr);
            }
            printf("\n");
        }
        fscanf(f1,"%s",in);
    }
    printf("E^00%x",reloc);
}