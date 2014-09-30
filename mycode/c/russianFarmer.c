#include<stdio.h>
#include<string.h>
#include<stdlib.h>

char *div2(char *);
char *doubler(char *);
int char2int(char );
char int2char(int);
char *charPlus(char *a, char *b);
int isOdd(char *a);

int char2int(char c)
{
    int num = c - '0';
    return num;
}

char int2char(int i)
{
    char c = i + '0';   
    return c;
}

char *doubler(char *a)
{
    char *p;
    int len = strlen(a);
    int plen = len;
    int s = 0;
    int atail = len - 1;

    if(*a < '5'){
        plen -= 1;
    }

    p = (char *)malloc(sizeof(char) * plen );
    p[0] = '0';

    while(atail >= 0)
    {
        int num; 
        num = char2int(a[atail--]) * 2 + s;
        p[plen--] = int2char(num % 10);
        s = (int)(num / 10);
    }
    if(p[0] == '0'){
        p[0] = int2char(s);
    }

    return p;
}

char *div2(char *a)
{
    char *p;  
    int len = strlen(a);
    int plen = len;
    int s = 0;
    if( *a < '2'){
        plen -= 1;
    }
   
    p = (char *)malloc(sizeof(char) * plen );
    int i=0,j=0;
    while(i<plen && j<len){
        int num = s * 10 + char2int(a[j++]);
        s = num % 2;
        p[i++] = int2char((int)(num / 2));
        if(i == 1 && p[0] == '0'){
            i--;
        }
    }
    return p;
}

int isOdd(char *a)
{
    int i = strlen(a) - 1;
    if(char2int(a[i]) % 2 == 1){
        return 1;
    }
    return 0;
}

char *charPlus(char *a, char *b)
{
    int lena = strlen(a);
    int lenb = strlen(b);
    int len = (lena > lenb ) ? lena : lenb; 
    int num[len];
    memset(num, 0, len);
    int tail = len;
    int i = lena - 1, j = lenb - 1;
    int s = 0;
    while(i >= 0 || j >= 0){
        int anum, bnum; 
        if( i >= 0 ){
            anum = char2int(a[i--]); 
        }else{
            anum = 0; 
        }

        if( j >= 0 ){
            bnum = char2int(b[j--]); 
        }else{
            bnum = 0; 
        }

        int res = anum + bnum;
        num[tail--] = res % 10 + s;
        s = (int)(res/10);
    }
    int plen = 0;
    num[0] = s;
    int k = 0;
    if(s != 0){
        plen = len;
    }else{
        k = 1;
        plen = len - 1;
    }
    
    char *p = (char *)malloc(sizeof(char) * plen);
    int pi = 0;
    for(;k<=len;k++){
        p[pi++] = int2char(num[k]);
    }
    return p;
}

char *russianFarmer(char *a, char *b)
{
    char *c = a, *d = b; 
    char *res = "0";
    if(isOdd(d)){
        res = charPlus(res,c);
    }
    while(!(strlen(d) == 1 && *d == '1')){
        c = doubler(c);
        d = div2(d);
        if(isOdd(d)){
            res = charPlus(res,c);
        }
    }
    return res;
}

int main()
{
    char *a = "1243";
    char *b = "5";
    char *c, *d, *e, *f;
    c = doubler(a);
    d = div2(a); 
    e = charPlus(a, b);
    f = russianFarmer(a,b);
    //printf("%s %s %s\n",c,d,e);
    printf("%s\n",f);
    return 0;
}

