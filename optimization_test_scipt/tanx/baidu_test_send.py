import httplib
import random
import baidu_realtime_bidding_pb2 
import string
import time

MAX_MINIMUM_CPM = 5000
MAX_AD_BLOCK_KEY=1000*100
ID_LENGTH = 32
BAIDU_USER_ID_LENGTH = 32
BAIDU_USER_ID_VERSION = 1
MAX_CREATIVE_TYPE_NUM = 4
MAX_PAGE_KEYWORD_NUM = 3
MAX_EXCLUDED_PRODUCT_CATEGORY_NUM = 10
MAX_EXCLUDED_LANDING_PAGE_URL_NUM = 10

LANGUAGE_CODES = ['en',"zh-cn","zh-tw" ]
GENDER = [ 0, 1, 2]
CREATIVE_TYPES = [ 1, 2 ]
SLOT_VISIBILITY = [ 0, 1, 2 ]
ADSLOT_TYPE = [ 0, 1, 2 ] 
SITE_CATEGORY = [ i for i in range(1,24) ] 
SITE_QUALITY = [ 0, 1, 2, 3 ] 
PAGE_TYPE = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13 ] 
PAGE_QUALITY = [ 0, 1 ] 
PRODUCT_CATEGORY = [ i for i in range(54,87) ]
PAGE_KEYWORDS = [ "baidu1", 
                  "baidu2",
                  "baidu3",
                  "baidu4",
                  "baidu5",
                  "baidu6",
                  "baidu7",
                  "baidu8",
                  "baidu9",
                  "baidu10",
]
LANDING_PAGE_URLS = [
        "www.landing_page1.com",
        "www.landing_page2.com",
        "www.landing_page3.com",
        "www.landing_page4.com",
        "www.landing_page5.com",
        "www.landing_page6.com",
        "www.landing_page7.com",
        "www.landing_page8.com",
        "www.landing_page9.com",
        "taobao.com",
]
URLS = [
        "www.baidu1.com",
        "www.baidu2.com",
        "www.baidu3.com",
        "www.baidu4.com",
        "www.baidu5.com",
        "www.baidu6.com",
        "www.baidu7.com",
        "www.baidu8.com",
        "www.baidu9.com",
        "www.baidu10.com",
]
REFERERS = [
        "www.baidu_refer1.com",
        "www.baidu_refer2.com",
        "www.baidu_refer3.com",
        "www.baidu_refer4.com",
        "www.baidu_refer5.com",
        "www.baidu_refer6.com",
        "www.baidu_refer7.com",
        "www.baidu_refer8.com",
        "www.baidu_refer9.com",
        "www.baidu_refer10.com",
]
AD_SIZES = [
        (300, 250),
        (960, 90),
        (336, 280),
        (200, 200),
        (728, 90),
        (640, 60),
        (640, 80),
        (120, 600),
        (250, 250),
        (960, 60),
        (468, 60),
        (160, 600),
]
USER_CATEGORY = [ 
        240010,
        240020,
        240030,
        240040,
        240050,
        240060,
        240070,
        240080,
        240090,
        250010,
        250020,
        270010,
]
USER_AGENTS = [
    'Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.0.2) '
    'Gecko/2008092313 Ubuntu/8.04 (hardy) Firefox/3.1',
    'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.2pre) '
    'Gecko/20070118 Firefox/2.0.0.2pre',
    'Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.7pre) Gecko/20070815 '
    'Firefox/2.0.0.6 Navigator/9.0b3',
    'Mozilla/5.0 (Macintosh; U; PPC Mac OS X 10_4_11; en) AppleWebKit/528.5+'
    ' (KHTML, like Gecko) Version/4.0 Safari/528.1',
    'Mozilla/5.0 (Macintosh; U; PPC Mac OS X; sv-se) AppleWebKit/419 '
    '(KHTML, like Gecko) Safari/419.3',
    'Mozilla/5.0 (Windows; U; MSIE 7.0; Windows NT 6.0; en-US)',
    'Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.0;)',
    'Mozilla/4.08 (compatible; MSIE 6.0; Windows NT 5.1)',
]

random.seed(time.time())

class BidRequestGenerator(object):
    def __init__(self):
        pass

    def GenerateRequest(self):
        bid_request = baidu_realtime_bidding_pb2.BidRequest()
        bid_request.id = self._GenerateId(ID_LENGTH)
        self._GenerateUserInfo(bid_request)
        self._GeneratePageInfo(bid_request)
        self._GenerateAdslot(bid_request)
        return bid_request

    def _GenerateId(self,length):
        allow_list = string.ascii_lowercase + string.digits
        id = [ random.choice(allow_list) for _ in range(length) ]
        return "".join(id)

    def _GenerateUserInfo(self,bid_request):
        bid_request.ip = ".".join([ str(random.randint(0,255)) for _ in range(4) ]) 
        bid_request.user_agent = random.choice(USER_AGENTS)
        bid_request.baidu_user_id = self._GenerateId(BAIDU_USER_ID_LENGTH)
        bid_request.baidu_user_id_version = BAIDU_USER_ID_VERSION
        bid_request.user_category = random.choice(USER_CATEGORY)
        bid_request.gender = random.choice(GENDER)
        bid_request.detected_language = random.choice(LANGUAGE_CODES)
        return
    
    def _GenerateAdslot(self,bid_request):
        ad_slot = bid_request.adslot.add()
        ad_slot.ad_block_key = random.randint(1,MAX_AD_BLOCK_KEY) 
        ad_slot.sequence_id = random.randint(1,32)
        ad_slot.width, ad_slot.height = random.choice(AD_SIZES)
        ad_slot.adslot_type = random.choice(ADSLOT_TYPE)

        ad_slot.slot_visibility = random.choice(SLOT_VISIBILITY) 
        num_creative_type = random.randint(1,MAX_CREATIVE_TYPE_NUM)
        for creative in self._GenerateSet(CREATIVE_TYPES,num_creative_type):
            ad_slot.creative_type.append(creative)
        num_excluded_landing_page_url = random.randint(1, MAX_EXCLUDED_LANDING_PAGE_URL_NUM )
        for excluded_url  in self._GenerateSet(LANDING_PAGE_URLS,num_excluded_landing_page_url):
            ad_slot.excluded_landing_page_url.append( excluded_url) 
        ad_slot.minimum_cpm  = random.randint(1000,MAX_MINIMUM_CPM)
        return 

    def _GeneratePageInfo(self, bid_request):
        bid_request.url = random.choice(URLS) 
        bid_request.referer = random.choice(REFERERS) 
        bid_request.site_category = random.choice(SITE_CATEGORY)
        bid_request.site_quality = random.choice(SITE_QUALITY)
        bid_request.page_type = random.choice(PAGE_TYPE)
        num_page_keyword = random.randint(1,MAX_PAGE_KEYWORD_NUM)
        for keyword in self._GenerateSet(PAGE_KEYWORDS,num_page_keyword):
            bid_request.page_keyword.append(keyword) 
        
        bid_request.page_quality = random.choice(PAGE_QUALITY)
        num_excluded_product_category = random.randint(1,MAX_EXCLUDED_PRODUCT_CATEGORY_NUM)
        for excluded_category in self._GenerateSet(PRODUCT_CATEGORY,num_excluded_product_category):
            bid_request.excluded_product_category.append(excluded_category)
        return 

    def _GenerateSet(self,collection,set_size):
        unique_collection = set(collection)
        if len(unique_collection) < set_size:
            return unique_collection
        s = set()
        while len(s) < set_size:
            s.add(random.choice(collection))
        return s;

def make_case():
    bidrequest = BidRequestGenerator().GenerateRequest()
    data = string.ljust("hello",10,"x")
    str_data = bidrequest.SerializeToString()
    return data

def recv_response(data):
    bidresponse = baidu_realtime_bidding_pb2.BidResponse()
    bidresponse.ParseFromString(data)

def main():
    connection = httplib.HTTPConnection('183.56.131.131','2222')
    times = 4
    for i in range(times):
	connection.request('POST','/baidu_bid',make_case(),{'Content-type':'application/octet-stream', 'Connection':'keep-alive'})
	response = connection.getresponse()
	print response.status, response.reason
	data = response.read()
	recv_response(data[:-1])

if __name__ == '__main__':
    main()
