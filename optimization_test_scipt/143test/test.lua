local logger = require 'shared.log'
local util = require 'shared.util'

function BaiduBidHandler:parse_request(req)
   -- local req = bilinbid.Parse(data, self.ad_exchange, #data)
    logger:debug("req=%s",logger:tostring(req))
    if not req then
	--TODO send a null bid response, it may occur some error, when parse the proto msg
	return
    end
    -------------------request info
    local bid = req.id

    -------------------user info
    --for gender: 0(UNKNOWN), 1(MALE), 2(FEMALE)
    local ip, ua = req.ip, req.user_agent
    local baidu_user_id, baidu_user_id_ver = req.baidu_user_id, req.baidu_user_id_version
    local user_category,gender = req.user_category, req.gender
    local detected_language = req.detected_language
    local geo_info = req.user_geo_info and req.user_geo_info.user_location or {}

    ---------------------page info
    local url,referer,site_category = req.url or '',req.referer,req.site_category
    local site_quality,page_type = req.site_quality, req.page_type
    local page_keyword,page_quality = req.page_keyword, req.page_quality
    local page_vertical,excluded_product_category = req.page_vertical,req.excluded_product_category

    ---------------------reserverd for system usage
    local is_test, is_ping = req.is_test, req.is_ping

    ---------------------READ OUR INFOMATION BY GIVEN BID REQUEST
    local domain,language = util.get_domain_from_url(url), util.get_normalized_lang(detected_language)
    local browser, os = util.get_browser_from_agent(ua), util.get_os_from_agent(ua)
    local bilin_user_id = Segments:translate_user_id(baidu_user_id) 
	local segments = Segments:new({cookie=bilin_user_id, domain = domain, url = url})

    segments:fetch_data()
    local results = {}
    ---------------------parse the adslots
    for _, adslot in ipairs(req.adslot or {}) do
        local bid_context = {
            bid_id = bid,
            exchange_user_id = baidu_user_id,
            bilin_user_id = bilin_user_id,
            ad_exchange = self.ad_exchange,
            user_ip = ip,
            user_city = geo_info.city, 
            language = language,
            domain = domain and string.lower(domain) or 'unknown',
            url = url and string.lower(url) or 'unknown',
            browser = browser and string.lower(browser) or 'unknown',
            os = os and string.lower(os) or 'unknown',
			user_agent = ua,
            site_category = site_category,
            adslot = adslot,
            is_test = is_test,

            ---------------------BES specific field
            geo_info = geo_info,
            user_category = util.array2hash(user_category),
            user_gender = gender,
            user_province = geo_info.province,
            user_district = geo_info.district,
            user_steet = geo_info.street,
            referer = referer,
            site_quality = site_quality,
            page_type = page_type,
            page_category = page_vertical,
            page_keyword = util.array2hash(page_keyword),
            page_quality = page_quality
        }
        bid_context.excluded_ad_category_hash = util.array2hash(excluded_product_category)
        bid_context.excluded_through_url_hash = util.array2hash(adslot.excluded_landing_page_url)

        --------BES specific field
        bid_context.allowed_creative_type_hash = util.array2hash(adslot.creative_type) 
        
        if adslot.width and adslot.height then
            bid_context.size = {adslot.width..'x'..adslot.height}
            table.insert(results, {context=bid_context, segments=segments})
        end

        logger:debug('parse results: %s',logger:tostring(results))
    end
    return results
end

