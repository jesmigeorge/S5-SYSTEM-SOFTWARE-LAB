#include <stdio.h>
#include <stdlib.h>
void main()
{
    int i,j,n,head,req[30],seekcnt=0;
    printf("Enter head : ");
    scanf("%d",&head);
    printf("Enter no of requests : ");
    scanf("%d",&n);
    printf("Enter requests : ");
    for(i=0;i<n;i++)
        scanf("%d",&req[i]);
    printf("Seek Seq : %d ",head);
    for(i=0;i<n;i++)
    {
        printf("%d ",req[i]);
        seekcnt+=abs(req[i]-head);
        head=req[i];
    }
    printf("\nSeekCnt : %d\n",seekcnt);
}