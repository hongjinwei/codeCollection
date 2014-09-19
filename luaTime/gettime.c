#include<sys/time.h>
#include<stdio.h>
#include<unistd.h>
#include<stdlib.h>
#include<memory.h>
struct timeval tv;
struct timezone tz;

/*struct timeval{
 *      long tv_sec ; //second
 *      long tv_usec; // u second
 * }
 *
 * struct timezone{
 *      int tz_minuteswest; //how many minutes diff from Greenwich
 *      int tz_dsttime; //?
 * }
 */

//struct utime{
//    int sec;
//    int usec;
//};

//memset(time,'0',25);
char* gettime()
{
    char* ctime= malloc(sizeof(char)* 18); //ctime[18];
    //struct utime returnTime;
    struct timeval tv;
    struct timezone tz;
    //double returnTime;
    gettimeofday(&tv, &tz);
  //  printf("tv_sec: %ld\n",tv.tv_sec);
  //  printf("tv_usec: %ld\n",tv.tv_usec);
  //  printf("tz_minuteswest: %d\n",tz.tz_minuteswest);
  //  printf("tz_dsttime: %d\n",tz.tz_dsttime);
  //  returnTime = tv.tv_sec + ((double)tv.tv_usec)/1000000;
    int i = 0;
    for(i=0;i<17;i++){
        if(i<10){
            ctime[9-i] = tv.tv_sec % 10 + '0';
            tv.tv_sec = (int)(tv.tv_sec/10);
        }
        if(10==i){
            ctime[i] = '.';
        }
        if(i>10){
            ctime[27-i] = tv.tv_usec % 10 + '0';
            tv.tv_usec = (int)(tv.tv_usec/10);
        }
    }

    ctime[17] = '\0';
    //sprintf(time,"%f",returnTime);
    //returnTime.sec = tv.tv_sec; 
    //returnTime.usec = tv.tv_usec ;
    //const char *p = ctime;
    return ctime;
}

int hello()
{
    printf("hello");
    return 0;
}

int main()
{
    //double s = 0;
    //s = gettime();
    //printf("%f\n",s);
    //struct utime t;
    char *t;
    t = gettime(); 
    printf("%s",t);
    return 0;
}

