#include <stdio.h>
struct process{
    int pid,at,bt,ct,tt,rt,wt;
}p[10];
int r=0,f=0,rq[20],ct[20],t,n;
void sort() 
{ 
    for (int i = 0; i < n; i++) 
        for (int j = 0; j < n-i-1; j++) 
            if (p[j].at>p[j+1].at) 
            { 
                struct process temp=p[j]; 
                p[j]=p[j+1]; 
                p[j+1]=temp; 
            } 
} 

void rr()
{
    int i,c=p[0].at,count=1;
    rq[r++]=0;
    while(f!=r)
    {
        int curr=rq[f];
        if (p[curr].rt>t){
            p[curr].rt-=t;
            c+=t;
        }
        else{
            c+=p[curr].rt;
            p[curr].rt=0;
        }
        p[curr].ct=c;
        ct[f++]=c;
        if (count<n)
            for(i=count;i<n && p[i].at<=c;i++)
            {
                rq[r++]=i;
                count++;
            }
        if (p[curr].rt>0)
            rq[r++]=curr;
    }
    for(i=0;i<n;i++)
    {
        p[i].tt=p[i].ct-p[i].at;
        p[i].wt=p[i].tt-p[i].bt;
    }
}

void gant()
{
    int i,j;
    for(i=0;i<ct[0];i++)
        printf("--");
    printf(" ");
    for(i=1;i<r;i++)
    {
        for(j=0;j<ct[i]-ct[i-1];j++)
            printf("--");
        printf(" ");
    }
    printf("\n|");
    for(i=0;i<ct[0]-1;i++)
        printf(" ");
    printf("P%d",p[rq[0]].pid);
    for(i=0;i<ct[0]-1;i++)
        printf(" ");
    printf("|");
    for(i=1;i<r;i++)
    {
        for(j=0;j<ct[i]-ct[i-1]-1;j++)
            printf(" ");
        printf("P%d",p[rq[i]].pid);
        for(j=0;j<ct[i]-ct[i-1]-1;j++)
            printf(" ");
        printf("|");
    }
    printf("\n");
    for(i=0;i<ct[0];i++)
        printf("--");
    printf(" ");
    for(i=1;i<r;i++)
    {
        for(j=0;j<ct[i]-ct[i-1];j++)
            printf("--");
        printf(" ");
    }
    printf("\n%d",p[0].at);
    if (ct[0]<9)
        for(i=0;i<2*ct[0];i++)
            printf(" ");
    else
        for(i=0;i<2*ct[0]-1;i++)
            printf(" ");
    printf("%d",ct[0]);
    for(i=1;i<r;i++)
    {
        if (ct[i]-ct[i-1]<=9)
            for(j=0;j<2*(ct[i]-ct[i-1]);j++)
                printf(" ");
        else
            for(j=0;j<2*(ct[i]-ct[i-1])-1;j++)
                printf(" ");
        printf("%d",ct[i]);
    }
    printf("\n\n");
}
void avg() 
{ 
    int sumw=0,sumt=0; 
    for (int i = 0; i <n;i++) 
    { 
        sumt+=p[i].tt; 
        sumw+=p[i].wt; 
    } 
    printf("Average TAT: %d\n",sumt/n); 
    printf("Average WT: %d\n",sumw/n); 
} 
void main()
{
    printf("Enter the number of processes: "); 
    scanf("%d", &n); 
    printf("Enter the arrival time of processes: "); 
    for (int i = 0; i < n; i++) 
        scanf("%d", &p[i].at); 
    printf("Enter the bt of processes: "); 
    for (int i = 0; i < n; i++) 
    {
        scanf("%d", &p[i].bt);
        p[i].pid=i+1;
        p[i].ct=0;
        p[i].rt=p[i].bt;
    }
    printf("Enter the time quanta: "); 
    scanf("%d", &t); 
    sort(); 
    rr();
    printf("--------------------------------------------------------------------------------------\n"); 
    printf("Process no. Arrival time Burst time Completion time Waiting time Turn around time\n"); 
    printf("--------------------------------------------------------------------------------------\n"); 
    for (int i = 0; i < n; i++) 
        printf("%d\t\t%d\t\t%d\t\t%d\t\t%d\t\t%d\n", p[i].pid,p[i].at,p[i].bt,p[i].ct,p[i].wt,p[i].tt); 
    printf("--------------------------------------------------------------------------------------\n"); 
    gant();
    avg();
}