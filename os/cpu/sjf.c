#include <stdio.h>
struct process{
    int pid,at,bt,ct,wt,tt,s;
}p[10];
int n;
void sort()
{
    int i,j;
    struct process temp;
    for(i=0;i<n-1;i++)
        for(j=0;j<n-i-1;j++)
            if (p[j].at>p[j+1].at)
                temp=p[j],p[j]=p[j+1],p[j+1]=temp;
}

void sjf()
{
    int c,count=1;
    c=p[0].ct=p[0].at+p[0].bt;
    p[0].tt=p[0].ct-p[0].at;
    p[0].wt=p[0].tt-p[0].bt;
    while (count<n)
    {
        int i,j,min,ind;
        for(i=1;i<n;i++)
        {
            if (p[i].s!=1)
            {
                min=p[i].bt,ind=i;
                break;
            }
        }
        for(j=i+1;p[j].at<=c && j<n;j++)
            if (p[i].bt<min && p[j].s==0)
                ind=i;
        p[ind].ct=c+p[ind].bt;
        c=p[ind].ct;
        p[ind].s=1;
        p[ind].tt=p[ind].ct-p[ind].at;
        p[ind].wt=p[ind].tt-p[ind].bt;
        count+=1;
    }

}

void gantt()
{
    int i,j;
    printf("GANTT CHART\n ");
    for(i=0;i<n;i++)
    {
        for(j=0;j<p[i].bt;j++)
            printf("--");
        printf(" ");
    }
    printf("\n|");
    for(i=0;i<n;i++)
    {
        for(j=0;j<p[i].bt-1;j++)
            printf(" ");
        printf("P%d",i);
        for(j=0;j<p[i].bt-1;j++)
            printf(" ");
        printf("|");
    }
    printf("|\n");
    for(i=0;i<n;i++)
    {
        for(j=0;j<p[i].bt;j++)
            printf("--");
        printf(" ");
    }
    printf("\n%d",p[0].at);
    for(i=0;i<n;i++)
    {
        if (p[i].at>9)
            for(j=0;j<2*p[i].bt-1;j++)
                printf(" ");
        else
            for(j=0;j<2*p[i].bt;j++)
                printf(" ");
        printf("%d",p[i].ct);
    }
    printf("\n");
}

void average()
{
    float sumw = 0, sumt = 0;
    for (int i = 0; i < n; i++)
    {
        sumw += p[i].wt;
        sumt += p[i].tt;
    }
    printf("\n\nAverage Waiting Time = %0.3f", sumw / n);
    printf("\nAverage Turnaround Time = %0.3f\n", sumt / n);
}

void main()
{
    int i,j;
    printf("Enter no of processes : ");
    scanf("%d",&n);
    for(i=0;i<n;i++)
        p[i].pid=i;
    printf("Enter at : ");
    for(i=0;i<n;i++)
        scanf("%d",&p[i].at);
    printf("Enter bt : ");
    for(i=0;i<n;i++)
        scanf("%d",&p[i].bt);
    for(i=0;i<n;i++)
        p[i].s=0;
    sort();
    sjf();
    printf("\n\nSJF\n");
    printf("\n------------------------------------------------------------------------\n");
    printf("Processes Arrival time Burst time Completion Time Waiting time Turnaround time\n");
    printf("------------------------------------------------------------------------\n");
    for (int i = 0; i < n; i++)
        printf("P%d\t\t%d\t\t%d\t\t%d\t\t%d\t\t%d\n",p[i].pid,p[i].at, p[i].bt, p[i].ct,p[i].wt,p[i].tt);
    printf("------------------------------------------------------------------------\n");
    gantt();
    average();
}