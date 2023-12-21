#include <stdio.h>
int n,fr,r=-1,f=-1,size=0,q[10];
int search(int num)
{
    int i;
    for(i=f;i<=r;i++)
        if (q[i]==num)
            return 1;
    return 0;
}

void enq(int num)
{
    if (r==-1)
        f=0;
    r++;
    q[r]=num;
    size++;
}

void deq()
{
    f++;
    size--;
}

void main()
{
    int i,hit=0,ref[20];
    printf("Enter frame size : ");
    scanf("%d",&fr);
    printf("Enter ref str len : ");
    scanf("%d",&n);
    printf("Enter ref str : ");
    for(i=0;i<n;i++)
        scanf("%d",&ref[i]);
    for(i=0;i<n;i++)
    {
        if (search(ref[i]))
            hit++;
        else
        {
            if (size<fr)
                enq(ref[i]);
            else{
                deq();
                enq(ref[i]);
            }
        }
    }
    printf("\nHits : %d\n",hit);
}