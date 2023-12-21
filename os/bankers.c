#include <stdio.h>
int p,r,flag,count=0,alloc[10][10],max[10][10],need[10][10],avail[10][10],safe[10],c[10],ind=0,z;
void main()
{
    int i,j,k;
    printf("Enter no of processes : ");
    scanf("%d",&p);
    printf("Enter no of resources : ");
    scanf("%d",&r);
    printf("Enter max : \n");
    for(i=0;i<p;i++)
    {
        printf("P%d : ",i+1);
        for(j=0;j<r;j++)
            scanf("%d",&max[i][j]);
    }
    printf("Enter alloc : \n");
    for(i=0;i<p;i++)
    {
        printf("P%d : ",i+1);
        for(j=0;j<r;j++)
        {
            scanf("%d",&alloc[i][j]);
            need[i][j]=max[i][j]-alloc[i][j];
        }
    }
    printf("Enter available : \n");
    for(i=0;i<r;i++)
        scanf("%d",&avail[ind][i]);
    for(i=0;i<p;i++)
        c[i]=0;
    while (count<p)
    {
        flag=0;
        for(i=0;i<p;i++)
        {
            if (c[i])
                continue;
            for(j=0;j<r;j++)
                if (avail[ind][j]<need[i][j])
                    break;
            if (j==r)
            {
                c[i]=1;
                for(k=0;k<r;k++)
                    avail[ind+1][k]=avail[ind][k]+alloc[i][k];
                ind+=1;
                safe[z]=i;
                flag=1;
                z+=1;
                count+=1;
            }
        }
        if(!flag)
        {
            printf("Deadlock detected\n");
            break;
        }
    }
    if (count==p)
    {
        printf("P\tMax\tAlloc\tAvail\tNeed\n");
        for(i=0;i<p;i++)
        {
            printf("%d\t",i);
            for(j=0;j<r;j++)
                printf("%d ",max[i][j]);
            printf("  ");
            for(j=0;j<r;j++)
                printf("%d ",alloc[i][j]);
            printf("  ");
            for(j=0;j<r;j++)
                printf("%d ",avail[i][j]);
            printf("  ");
            for(j=0;j<r;j++)
                printf("%d ",need[i][j]);
            printf("\n");
        }
        printf("Safe state : ");
        for(i=0;i<z;i++)
            if (i==z-1)
                printf("P%d\n",safe[i]);
            else
                printf("P%d--->",safe[i]);
    }  
}

