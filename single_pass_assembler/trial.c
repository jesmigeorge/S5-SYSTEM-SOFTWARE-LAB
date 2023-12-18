#include <stdio.h>
#include <stdlib.h>
#include <string.h>
char *itooa(int num,char *str)
{
    if (str==NULL)
        return NULL;
    sprintf(str,"%x",num);
    return str;
}
void main()
{
    FILE *f1,*f2,*f3,*f4,*f5;
    char name[20],la[20],mne[20],opnd[20],mne1[20],opnd1[20],s1[5],s2[5],s3[5];
    char sym[20],symaddr[20],lcs[20][20],q[20],obj1[20],obj2[20];
    int sa,lc,m[50],i=0,j=0,k=0,reclen=0,pgmlen;
    f1=fopen("input.txt","r");
    f2=fopen("optab.txt","r");
    f3=fopen("symtab.txt","w+");
    f4=fopen("symtab1.txt","w+");
    f5=fopen("output.txt","w+");
    strcpy(s1,"*");
    strcpy(s2,"-");
    strcpy(s3,"#");
    fscanf(f1,"%s %s %x",la,mne,&lc);
    if (strcmp(mne,"START")==0)
    {
        sa=lc;
        strcpy(name,la);
    }
    fscanf(f1,"%s %s %s",la,mne,opnd);
    while (strcmp(mne,"END")!=0)
    {
        if (strcmp(la,"-")==0)
        {
            fscanf(f2,"%s %s",mne1,opnd1);
            while(!feof(f2))
            {
                if (strcmp(mne1,mne)==0)
                {
                    m[i]=lc;
                    i++;
                    lc+=3;
                    fprintf(f3,"%s %s\n",opnd,s1);
                    fprintf(f5,"%s\t0000\n",opnd1);
                    break;
                }
                fscanf(f2,"%s %s",mne1,opnd1);
            }
            reclen+=6;
        }
        else
        {
            fseek(f3,SEEK_SET,0);
            fscanf(f3,"%s %s",sym,symaddr);
            while(!feof(f3))
            {
                if (strcmp(la,sym)==0)
                {
                    itooa(lc,lcs[k]);
                    fprintf(f4,"%s %s\n",la,lcs[k]);
                    fprintf(f5,"%x %s\n",m[j],lcs[k]);
                    k+=1;
                    j+=1;
                    break;
                }
                fscanf(f3,"%s %s",sym,symaddr);
            }
            if (strcmp(mne,"RESW")==0)
                lc+=3*atoi(opnd);
            else if (strcmp(mne,"RESB")==0)
                lc+=atoi(opnd);
            else if (strcmp(mne,"WORD")==0)
            {
                lc+=3;
                fprintf(f5,"%s %s\n",opnd,s3);
                reclen+=strlen(opnd);
            }
            else if (strcmp(mne,"BYTE")==0)
            {
                int z=0;
                lc+=strlen(opnd)-2;
                for(int a=2;a<strlen(opnd);a++){
                    q[z]=opnd[a];
                    z++;
                }
                q[z]='\0';
                fprintf(f5,"%s %s\n",q,s2);
                reclen+=strlen(opnd)-2;
            }  
        }
        fseek(f2,SEEK_SET,0);
        fscanf(f1,"%s %s %s",la,mne,opnd);
    }
    pgmlen=lc-sa;
    k=0;
    fseek(f5,SEEK_SET,0);
    fscanf(f5,"%s %s",obj1,obj2);
    printf("H^%-6s^%06x^%06x\n",name,sa,pgmlen);
    printf("T^00%x^%x",sa,reclen/2);
    while(!feof(f5))
    {
        if (strcmp(obj2,"0000")==0)
            printf("^%s%s",obj1,lcs[k++]);
        else if (strcmp(obj2,"-")==0)
        {
            printf("^");
            for(int a=0;a<strlen(obj1);a++)
                printf("%x",obj1[a]);    
        }
        else if (strcmp(obj2,"#")==0)
            printf("^%s",obj1);
        fscanf(f5,"%s %s",obj1,obj2);
    }
    printf("\nE^%x\n",sa);
}