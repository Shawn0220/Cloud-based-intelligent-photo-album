# -*- coding: utf-8 -*-
import base64
import json
import uuid

import requests

TOKEN_URL = u'https://smartlib-api-changsha-1.cmecloud.cn:8444/ecloud/ai/oauth/getToken'
AK = 'CIDC-AK-40ed46fa-1b77-4842-8e23-1ff503629b1a'
SK = 'CIDC-SK-521aeb2f-b11c-4b87-99ce-169c9a2896e7'


def fetch_token():
    """
    通过AK、SK获取密钥（密钥具有时效性）
    PS：此处为了调用方便已忽略ssl安全验证
    :return: access token
    """
    param = {
        'grant_type': 'client_credentials',
        'client_id': AK,
        'client_secret': SK
    }
    token_response = requests.get(TOKEN_URL, params=param, verify=False)
    result = token_response.json()
    print(result)
    if 'access_token' in result.keys():
        return result['access_token']
    else:
        print('please check your API_KEY and SECRET_KEY')
        exit(1)


def fetch_example_data(imageurl):
    with open(imageurl, mode='rb') as f:
        img_base64 = str(base64.b64encode(f.read()), encoding='utf8')
    data = {
        'imageFile': img_base64
    }
    return json.dumps(data)


#
def request_example(imageurl):
    API_URL = u'https://smartlib-api-changsha-1.cmecloud.cn:8444/ecloud/ai/v1/face/v1/detect'
    # 获取access_token
    token = fetch_token()

    # 获取数据
    example_data = fetch_example_data(imageurl)

    params = {'access_token': token}
    header = {'Content-Type': 'application/json', 'Accept': 'application/json'}

    # post 请求，此处为了调用方便已忽略ssl安全验证z
    data = requests.post(url=API_URL, params=params, headers=header, data=example_data, verify=False)
    result = json.dumps(data.json(), ensure_ascii=False, indent=4)
    response = json.loads(result)
    print("response", response)
    return response


def search_similar_fetch_example_data(imageurl, faceNumber, faceSetId):
    with open(imageurl, mode='rb') as f:
        img_base64 = str(base64.b64encode(f.read()), encoding='utf8')
    data = {
        'faceNumber': faceNumber,
        'faceSetId': faceSetId,
        'imageFile': img_base64

    }
    return json.dumps(data)


def search_similar_request_example(imageurl):
    API_URL1 = u'https://smartlib-api-changsha-1.cmecloud.cn:8444/ecloud/ai/v1/face/v1/search'
    faceNumber = 1
    faceSetId = 118245

    # 获取access_token
    token = fetch_token()

    # 获取数据
    example_data = search_similar_fetch_example_data(imageurl, faceNumber, faceSetId)

    params = {'access_token': token}
    header = {'Content-Type': 'application/json', 'Accept': 'application/json'}

    # post 请求，此处为了调用方便已忽略ssl安全验证
    data = requests.post(url=API_URL1, params=params, headers=header, data=example_data, verify=False)
    result = json.dumps(data.json(), ensure_ascii=False, indent=4)
    response = json.loads(result)
    return response


def add_fetch_example_data(imageurl, faceName, faceSetId, faceExtraInfo):
    with open(imageurl, mode='rb') as f:
        img_base64 = str(base64.b64encode(f.read()), encoding='utf8')
    data = {'imageFile': img_base64, "faceSetId": faceSetId, "faceName": faceName, "faceExtraInfo": faceExtraInfo}
    return json.dumps(data)


def add_request_example(imageurl, addface_name, faceExtraInfo):
    # 增添人脸的API
    API_URL = u'https://smartlib-api-changsha-1.cmecloud.cn:8444/ecloud/ai/v1/face/v1/faceset/user/add'
    # 获取access_token
    token = fetch_token()

    faceName = addface_name
    faceSetId = 118245

    example_data = add_fetch_example_data(imageurl, faceName, faceSetId, faceExtraInfo)

    params = {'access_token': token}
    header = {'Content-Type': 'application/json', 'Accept': 'application/json'}

    data = requests.post(url=API_URL, params=params, headers=header, data=example_data, verify=False)
    result = json.dumps(data.json(), ensure_ascii=False, indent=4)
    response = json.loads(result)
    return response


def people_recognize(imageurl):
    detect_response = request_example(imageurl)
    # print(detect_response)
    if detect_response['state'] == 'OK':
        # print(detect_response)
        Similar_face = set()
        addface_name = ''
        search_similar_response = search_similar_request_example(imageurl)
        for i in search_similar_response['body']['results']:
            # print (i['faceName'])
            if i['confidence'] > 0.8:  # 最像的人脸置信度>0.8 认为是一个人
                Similar_face.add(i['faceName'])
                addface_name = i['faceName']  # 为下面上传图片的faceName参数赋值 取最像的人脸图片的Name
            else:
                # 如果在库里找的人脸不太像上传的人脸 则认为是新人 随机生成他的Name字符串
                addface_name = str(uuid.uuid1())

        faceExtraInfo = 'Null'  # ExtraInfo 图片的附加信息，看后面需求更改， 现在缺省 NULL
        add_response = add_request_example(imageurl, addface_name, faceExtraInfo)  # 向服务器请求添加人脸
        print('add_response:', add_response)  # 输出添加人脸API的返回值
        return add_response['body']['faceName']

    elif detect_response['state'] == 'ERROR':
        return 1  # "No face detected"

    else:
        return 2  # "eCloud异常"
