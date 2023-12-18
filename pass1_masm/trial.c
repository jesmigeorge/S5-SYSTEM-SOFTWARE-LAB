#include <stdio.h>
#include <stdlib.h>
#include <string.h>
void main()
{
    FILE *f1,*f2,*f3,*f4;
    char la[20],mne[20],opnd[20],mne1[20],opnd1[20];
    int sa,lc,pgmlen=0;
    f1=fopen("input.txt","r");
    f3=fopen("symtab.txt","w");
    f4=fopen("output.txt","w");
    fscanf(f1,"%s %s %x",la,mne,&sa);
    if (strcmp(mne,"START")==0)
    {
        lc=sa;
        printf("\n%s %s %x\n",la,mne,sa);
    }
    else
        lc=0;
    fscanf(f1,"%s %s %s",la,mne,opnd);
    while (strcmp(mne,"END")!=0)
    {
        printf("%x %s %s %s\n",lc,la,mne,opnd);
        if (strcmp(la,"-")==0)
        {
            f2=fopen("optab.txt","r");
            fscanf(f2,"%s %s",mne1,opnd1);
            while (!feof(f2))
            {
                if (strcmp(mne1,mne)==0)
                {
                    lc+=3;
                    break;
                }
                fscanf(f2,"%s %s",mne1,opnd1);
            }
            fclose(f2);
        }
        else
        {
            fprintf(f3,"%s %x\n",la,lc);
            if (strcmp(mne,"WORD")==0)
                lc+=3;
            else if (strcmp(mne,"RESW")==0)
                lc+=(3*atoi(opnd));
            else if (strcmp(mne,"RESB")==0)
                lc+=atoi(opnd);
            else if (strcmp(mne,"BYTE")==0)
                lc+=strlen(opnd)-2;
        }
        fscanf(f1,"%s %s %s",la,mne,opnd);
    }
    pgmlen=lc-sa;
    printf("%x %s %s %s\n",lc,la,mne,opnd);
    printf("Program length : %x",pgmlen);
}