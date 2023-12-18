#include <stdio.h>
#include <stdlib.h>
#include <string.h>
void main()
{
    FILE *f1,*f2,*f3,*f4;
    char name[20],la[20],mne[20],opnd[20],textrec[200],curr[20];
    char mne1[20],opnd1[20],sym[20],symaddr[20],temp[20];
    int lc,sa,reclen=0;
    f1=fopen("intermediate.txt","r");
    f4=fopen("output.txt","w");
    fscanf(f1,"%s %s %x",la,mne,&sa);
    while (!feof(f1))
        fscanf(f1,"%x %s %s %s",&lc,la,mne,opnd);
    fseek(f1,SEEK_SET,0);
    fscanf(f1,"%s %s %x",la,mne,&sa);
    if (strcmp(mne,"START")==0){
        fprintf(f4,"H^%-6s^00%x^00%x\n",la,sa,lc-sa);
        printf("H^%-6s^00%x^00%x\n",la,sa,lc-sa);
    }
    strcpy(textrec,"");
    fscanf(f1,"%x %s %s %s",&lc,la,mne,opnd);
    while (strcmp(mne,"END")!=0)
    {
        if (strcmp(la,"-")==0)
        {
            strcpy(curr,"^");
            f3=fopen("optab.txt","r");
            fscanf(f3,"%s %s",mne1,opnd1);
            while(!feof(f3))
            {
                if (strcmp(mne1,mne)==0)
                {
                    strcat(curr,opnd1);
                    break;
                }
                fscanf(f3,"%s %s",mne1,opnd1);
            }
            fclose(f3);
            f2=fopen("symtab.txt","r");
            fscanf(f2,"%s %s",sym,symaddr);
            while(!feof(f2))
            {
                if (strcmp(sym,opnd)==0)
                {
                    strcat(curr,symaddr);
                    break;
                }
                fscanf(f2,"%s %s",sym,symaddr);
            }
            fclose(f2);
            strcat(textrec,curr);
            reclen+=6;
        }
        else
        {
            if (strcmp(mne,"WORD")==0)
            {
                strcpy(curr,"^");
                strcat(curr,opnd);
                reclen+=strlen(opnd);
            }
            else if (strcmp(mne,"BYTE")==0)
            {
                
                for(int i=2;i<strlen(opnd);i++)
                {
                    sprintf(temp,"%x",opnd[i]);
                    strcat(curr,temp);
                }  
                reclen+=strlen(opnd)-2;
            }
            strcat(textrec,curr);
        }
        fscanf(f1,"%x %s %s %s",&lc,la,mne,opnd);
    }
    printf("T^00%x^%x^%s\n",sa,reclen/2,textrec);
    fprintf(f4,"T^00%x^%x^%s\n",sa,reclen/2,textrec);
    printf("E^00%x",sa);
    fprintf(f4,"E^00%x",sa);
    fclose(f1);
    fclose(f4);
}