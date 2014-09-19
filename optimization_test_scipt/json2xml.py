import json
import sys
reload(sys)
sys.setdefaultencoding( "utf-8" )
def json2xml(json_obj, line_padding=""):
    result_list = list()
        
    json_obj_type = type(json_obj)

    if json_obj_type is list:
        for sub_elem in json_obj:
            result_list.append(json2xml(sub_elem, line_padding))
        return "\n".join(result_list)

    if json_obj_type is dict:
        for tag_name in json_obj:
            sub_obj = json_obj[tag_name]
            result_list.append("%s<%s>" % (line_padding, tag_name))
            result_list.append(json2xml(sub_obj, "\t" + line_padding))
            result_list.append("%s</%s>" % (line_padding, tag_name))

        return "\n".join(result_list)
    return "%s%s" % (line_padding, json_obj)


file = open('/root/rtb/conf/config_simple.json')
#for line in file.readline():
#    print line
str = file.readline()
j_obj = json.loads(str)
print json2xml(j_obj)



