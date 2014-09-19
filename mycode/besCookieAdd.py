import httplib
import urllib,urllib2
import time, os
import re,os
import json
# -*- coding: utf-8 -*- 

#----------------------
BES_REQ_URL = ''
BES_API = ''
TIME = 2 #upload time interval
MATCH_PREFIX = 'cmc'
VERSION = 'v6_0_0'
COOKIES_PER_TIME = 20
INTERVAL = 0.1
LOG_PATH = '/yundisk/log/hadoop/'
DSPID = ""
TOKEN = ""
#----------------------
sum = {
        'missOperate' : [],
        'invalid' : [],
        'request_failed' : []
}

def collect_summary(res, sum, status, req):
    if status == 200:
        response = json.loads(res)
        for value in response.invalidCookies :
            sum.invalid.append(value)

        for value in response.missOperateCookis :
            sum.missOperate.append(value)
    
    else:
        for value in req.cookies :
            sum.request_failed.append(value)

def generateCookieList(cookie_list,filename):
    fp = open(filename, 'r')
    for line in fp.readlines():
        sp = line.split('\t')
        cookie_list.append(sp[4])


def wrapper(p, end, cookie_list):
    p_start = p
    req_body = {'authHeader': {
                        'dspId': DSPID,
                        'token': TOKEN
                    }
            }
    if p > len(cookie_list) :
        return None

    if p + COOKIES_PER_TIME > end:
        p_end = end
    else:
        p_end = p + COOKIES_PER_TIME 

    cookies = []
    for i in range(p_start, p_end):
        new_cookie = {}
        new_cookie['cookieId'] = cookie_list[i]
        new_cookie['expireDate'] = ('%d') % ((int(time.time()+30*24*3600)*1000))
        cookies.append(new_cookie)

    req_body['cookies'] = cookies
    return json.dumps(req_body)


def requester(cookie_list):
    p = 0
    end = len(cookie_list) 
    #http = httplib.HTTPConnection(BES_REQ_URL,80) 
    while p < 1:
    #while p < end:
        print p
        req_body = wrapper(p, end, cookie_list)
        #http.request('POST', BES_API, req_body, {"Content-Type": "application/json", "Connection": "keep-alive"})
        #req_body = urllib.urlencode(req_body)
        req = urllib2.Request(BES_REQ_URL, req_body)
        req.add_header('Content-Type','application/json')
        response = urllib2.urlopen(req)
        if response.code == 200:
            res = response.read()
            collect_summary(sum, res, 200)
        else:
            collect_summary(sum, res, response.code ,req_body)
        time.sleep(INTERVAL)
        p = p + COOKIES_PER_TIME
    http.close()

def upload():
    now = int(time.strftime('%Y%m%d%H')) 
    cookie_list = []
    match_time = []
    for ltime in range(now - TIME, now):
        match_time.append(MATCH_PREFIX+ '.*' + ('%d' % ltime))
    
    for listname in os.listdir(LOG_PATH):
        for name in match_time :
            if re.search(name, listname):
                generateCookieList(cookie_list, listname)

    print len(cookie_list)
    requester(cookie_list)
    print sum
        
if __name__ == '__main__' : 
    upload()


