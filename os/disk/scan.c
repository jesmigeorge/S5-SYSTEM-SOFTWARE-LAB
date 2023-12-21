#include <stdio.h>
#include <stdlib.h>
void main()
{
    int i,j,k,n,flag,head,seekcnt=0,max,req[20];
    printf("Enter head : ");
    scanf("%d",&head);
    printf("Enter max cylinder : ");
    scanf("%d",&max);
    printf("Enter no of requests : ");
    scanf("%d",&n);
    printf("Enter requests : ");
    for(i=0;i<n;i++)
        scanf("%d",&req[i]);
    printf("Seek seq : %d ",head);
    for(i=head;i<=max && n!=0;i++)
    {
        flag=0;
        for(j=0;j<n;j++)
        {
            if (req[j]==i)
            {
                flag=1;
                break;
            }
        }
        if (flag)
        {
            printf("%d ",i);
            seekcnt+=abs(i-head);
            head=i;
            for(k=j;k<n-1;k++)
                req[k]=req[k+1];
            n--;
        }
    }
    if (n!=0)
    {
        printf("%d ",max);
        seekcnt+=abs(max-head);
        head=max;
        for(i=max;i>=0 && n!=0;i--)
        {
            flag=0;
            for(j=0;j<n;j++)
            {
                if (req[j]==i)
                {
                    flag=1;
                    break;
                }
            }
            if (flag)
            {
                printf("%d ",i);
                seekcnt += abs(head-i);
                head=i;
                for(k=j;k<n-1;k++)
                    req[k]=req[k+1];
                n--;
            }
        }
    }
    printf("\nSeekcnt : %d\n",seekcnt);
}