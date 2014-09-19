import httplib

import tanx_pb2

def make_case():
    bidrequest = tanx_pb2.BidRequest()
    bidrequest.version = 3
    bidrequest.bid = "f44bf7e1d76396eb4ae9e8677f7f640f"
    bidrequest.is_test = 0
    bidrequest.is_ping = 0 
    bidrequest.tid = "t/eXPfnM4sXs2QP3Msea88Zl"
    bidrequest.ip = "96.52.70.76"
    bidrequest.user_agent = "Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.0.2)Gecko/2008092313 Ubuntu/8.04 (hardy) Chrome/3.1"
    bidrequest.timezone_offset = 480
    
    bidrequest.tid_version = 1
    bidrequest.excluded_click_through_url.append("http://clickthrough.domain9.com")
    bidrequest.url = "http://www.youtube.com"
    bidrequest.category = 40003
    bidrequest.adx_type = 0
    
    bidrequest.detected_language = "zh"
    bidrequest.category_version = 1
    adzinfo = bidrequest.adzinfo.add()
    adzinfo.id = 0
    adzinfo.pid = "mm_123_456_789"
    adzinfo.size = "300x250"
    adzinfo.ad_bid_count = 2
    adzinfo.view_type.append(5)
    adzinfo.excluded_filter.append(5)
    adzinfo.excluded_filter.append(7)
    adzinfo.min_cpm_price = 1 
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
    connection = httplib.HTTPConnection('183.56.131.131','2110')
    connection.request('POST','/tanx_bid_request',make_case(),{'Content-type':'application/octet-stream'})
    response = connection.getresponse()
    print response.status, response.reason
    data = response.read()
    recv_response(data)

if __name__ == '__main__':
    main()
