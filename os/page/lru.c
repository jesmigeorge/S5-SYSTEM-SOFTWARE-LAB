#include <stdio.h>
int top=-1,size=0,n,stack[50];
int search(int num)
{
    int i;
    for(i=0;i<=top;i++)
        if (stack[i]==num)
            return i;
    return -1;
}

void push(int num)
{
    top+=1;
    stack[top]=num;
    size+=1;
}

void pop()
{
    int i;
    for(i=0;i<top;i++)
        stack[i]=stack[i+1];
   top-=1;
   size-=1;
}
void main()
{
    int i,j,ind,len,temp,ref[20],hit=0;
    printf("Enter no of frames : ");
    scanf("%d",&n);
    printf("Enter len of ref str : ");
    scanf("%d",&len);
    printf("Enter ref str : ");
    for(i=0;i<len;i++)
        scanf("%d",&ref[i]);
    for(i=0;i<len;i++)
        printf("%d",ref[i]);
    for(i=0;i<len;i++)
    {
        ind=search(ref[i]);
        if (ind==-1)
        {
            if (size<n)
                push(ref[i]);
            else{
                pop();
                push(ref[i]);
            }
        }
        else
        {
            hit++;
            temp=stack[ind];
            for(j=ind;j<top;j++)
                stack[j]=stack[j+1];
            stack[top]=temp;
        }
        printf("pages in memory : ");
        for(j=0;j<=top;j++)
            printf("%d ",stack[j]);
        printf("\n");
    }
    printf("page faults : %d\n",len-hit);
}