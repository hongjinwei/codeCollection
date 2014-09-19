import httplib,time
import testData
import tanx_pb2
import random
import uuid

def make_case():
    test_pingNum = random.randint(0,1)
    categoryNum = random.randint(0,11)
    viewTypeNum = random.randint(0,8)
    filterNum = random.randint(0,8)
    priceNum = random.randint(0,2)
    id = uuid.uuid1().hex
    testData.data['bid']=id
    print('test_pingNum,categoryNum,viewTypeNum,filterNum,priceNum',test_pingNum,categoryNum,viewTypeNum,filterNum,priceNum)
    bidrequest = tanx_pb2.BidRequest()
    bidrequest.version = testData.data['version']
    bidrequest.bid = testData.data['bid'] 
    bidrequest.is_test = testData.data['is_test'][test_pingNum]
    bidrequest.is_ping = testData.data['is_ping'][test_pingNum]
    bidrequest.tid = testData.data['tid'] 
    bidrequest.ip = testData.data['ip'] 
    bidrequest.user_agent = testData.data['user_agent'][0] 
    bidrequest.timezone_offset = testData.data['timezone_offset'][test_pingNum]
    
    bidrequest.tid_version = testData.data['tid_version'] 
    bidrequest.excluded_click_through_url.append(testData.data['excluded_click_through_url'])
    bidrequest.url = testData.data['url']
    bidrequest.category = testData.data['category'][categoryNum]
    bidrequest.adx_type = testData.data['adx_type'][test_pingNum]
    
    bidrequest.detected_language = testData.data['detected_language'][test_pingNum]
    bidrequest.category_version = testData.data['category_version'] 
    adzinfo = bidrequest.adzinfo.add()
    adzinfo.id = 0
    adzinfo.pid = testData.data['pid'][test_pingNum]
    adzinfo.size = testData.data['size'][test_pingNum]
    adzinfo.ad_bid_count = testData.data['ad_bid_count'] 
    adzinfo.view_type.append(testData.data['view_type'][viewTypeNum])
    adzinfo.excluded_filter.append(testData.data['excluded_filter'][filterNum])
    adzinfo.min_cpm_price = testData.data['min_cpm_price'][priceNum] 
    adzinfo.view_screen = tanx_pb2.BidRequest.AdzInfo.SCREEN_NA

    str_data = bidrequest.SerializeToString()
    return str_data

def recv_response(data):
    bidresponse = tanx_pb2.BidResponse()
    bidresponse.ParseFromString(data)
    print("version:",bidresponse.version)
    print("bid:",bidresponse.bid)
    for ad in bidresponse.ads:
	print("adzinfo_id:",ad.adzinfo_id)
	print("max_cpm_price",ad.max_cpm_price)
	if ad.HasField('ad_bid_count_idx'):
	    print("ad_bid_count_idx",ad.ad_bid_count_idx)
	if ad.HasField('html_snippet'):
	    print("html_snippet",ad.html_snippet)
	for url in ad.click_through_url:
	    print("click_through_url:",url)
	for category in ad.category:
	    print("category:",category)
	for creative_type in ad.creative_type:
	    print("creative_type:",creative_type)
	if ad.HasField('network_guid'):
	    print("network_guid:",ad.network_guid)
	if ad.HasField('extend_data'):
	    print("extend_data:",ad.extend_data)
	for destination_url in ad.destination_url:
	    print("destination_url:",destination_url)
	if ad.HasField('creative_id'):
	    print("creative_id:",ad.creative_id)

def main():
	times=1
	#connection = httplib.HTTPConnection('172.16.250.64','2110', timeout=3)
	connection = httplib.HTTPConnection('183.56.131.131','2110')
	headers = {"Content-type":"application/octet-steam","Connection":"keep-alive"}
	for i in range(times):
		connection.request('POST','/tanx_bid_request',make_case(),headers)
		#connection.request('POST','/test',make_case(),headers)
		response = connection.getresponse()
		print response.getheaders()
		print response.status
		print response.reason
		data = response.read()
		print 'length', len(data)
		print(data)
		#recv_response(data)
	connection.close()
if __name__ == '__main__':
    main()
