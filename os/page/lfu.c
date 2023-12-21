#include <stdio.h>
struct frame{
    int pno;
    int c;
}f[10];
int fr,n,count=0;
void sort()
{
    int i,j;
    struct frame temp;
    for(i=0;i<count-1;i++)
        for(j=0;j<count-i-1;j++)
            if (f[j].c>f[j+1].c) 
            {
                temp=f[j];
                f[j]=f[j+1];
                f[j+1]=temp;
            }
}
int visit(int x)
{
    int i;
    for(i=0;i<count;i++)
        if (f[i].pno==x)
            return i;
    return -1;
}

void main()
{
    int i,j,ind,ref[20],fault;
    printf("enter length :");
    scanf("%d",&n);
    printf("enter frame size :");
    scanf("%d",&fr);
    printf("enter req seq :");
    for(i=0;i<n;i++)
        scanf("%d",&ref[i]);
    for(i=0;i<n;i++)
    {
        ind=visit(ref[i]);
        if (ind==-1)
        {
            fault++;
            if (count<fr){
                f[count].pno=ref[i];
                f[count].c=1;
                count++;
            }
            else{
                sort();
                for(j=0;j<count-1;j++)
                    f[j]=f[j+1];
                f[count-1].pno=ref[i];
                f[count-1].c=1;
            }
        }
        else
            f[ind].c+=1;
        printf("Frames now : ");
        for(int k=0;k<count;k++)
            printf("%d ",f[k].pno);
        printf("\n");
    }
    
    printf("Page Faults = %d\n",fault);
}
