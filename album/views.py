# -*- coding: utf-8 -*-
import datetime
import hashlib
import json
import locale
import os
import uuid
import zipfile
from urllib import parse
from utils import imgrecognize, Add_face_to_person_photos, makemovies
import exifread
import pymysql
import requests
from PIL import Image
from django.http import JsonResponse, HttpResponse
from django.shortcuts import render

# Create your views here.
from cloudPhoto import settings

database_host = 'localhost'
database_user = 'root'
database_password = '123456'
database_db = 'ecloudphoto'
locale.setlocale(locale.LC_CTYPE, 'chinese')
WEEK = {'Monday': '星期一', 'Tuesday': '星期二', 'Wednesday': '星期三', 'Thursday': '星期四',
        'Friday': '星期五', 'Saturday': '星期六', 'Sunday': '星期日'}


#  获取照片信息
class GetPhotoInfo:
    def __init__(self, photo):
        self.photo = photo
        # 百度地图ak  请替换为自己申请的ak
        self.ak = 'uhP0rZHC8g3bI2FlWkOYMNTyQXNWyDhP'
        self.time, self.lat, self.lon = self.get_photo_info()
        # print(self.time, self.lat, self.lon)

    def get_photo_info(self, ):
        tags = exifread.process_file(self.photo)
        # print(tags)
        Photo_time = ''
        lat = ''
        lon = ''
        if not bool(tags):
            print('照片无信息')
        else:
            # 打印照片其中一些信息
            if 'EXIF DateTimeOriginal' in tags.keys():
                Photo_time = tags['EXIF DateTimeOriginal']
                print('拍摄时间：', tags['EXIF DateTimeOriginal'])
            else:
                print('无拍摄时间')
            # print('照相机制造商：', tags['Image Make'])
            # print('照相机型号：', tags['Image Model'])
            # print('照片尺寸：', tags['EXIF ExifImageWidth'], tags['EXIF ExifImageLength'])
            # 纬度
            try:
                if "GPS GPSLatitudeRef" in tags.keys():
                    lat_ref = tags["GPS GPSLatitudeRef"].printable
                    lat = tags["GPS GPSLatitude"].printable[1:-1].replace(" ", "").replace("/", ",").split(",")
                    lat = float(lat[0]) + float(lat[1]) / 60 + float(lat[2]) / float(lat[3]) / 3600
                    if lat_ref != "N":
                        lat = lat * (-1)
                # 经度
                if "GPS GPSLongitudeRef" in tags.keys():
                    lon_ref = tags["GPS GPSLongitudeRef"].printable
                    lon = tags["GPS GPSLongitude"].printable[1:-1].replace(" ", "").replace("/", ",").split(",")
                    lon = float(lon[0]) + float(lon[1]) / 60 + float(lon[2]) / float(lon[3]) / 3600
                    if lon_ref != "E":
                        lon = lon * (-1)
                print("经纬度：", lat, lon)
            except IndexError as e:
                lat = ''
                lon = ''
                print("出错照片：", self.photo)
        return Photo_time, lat, lon

    def get_location(self):
        queryStr = '/reverse_geocoding/v3/?ak={}&output=json&coordtype=wgs84ll&location={},{}'.format(
            self.ak, self.lat, self.lon)
        encodedStr = parse.quote(queryStr, safe="/:=&?#+!$,;'@()*[]")
        # 在最后直接追加上yoursk
        rawStr = encodedStr + 'A9CeqTe50vcfaVSpt2lc9CyPLIxYDd69'
        # 计算sn
        sn = (hashlib.md5(parse.quote_plus(rawStr).encode("utf8")).hexdigest())
        # 由于URL里面含有中文，所以需要用parse.quote进行处理，然后返回最终可调用的url
        url = parse.quote("https://api.map.baidu.com" + queryStr + "&sn=" + sn, safe="/:=&?#+!$,;'@()*[]")
        print(url)
        response = requests.get(url).json()
        status = response['status']
        if status == 0:
            city = response['result']['addressComponent']['city']
            print('详细地址：', city)
            return city
        else:
            print(status)
            return ""


#  往数据库中插入照片
def insert_imgs(username, imgName, time, img_address, album, faceName):
    conn = pymysql.connect(host=database_host, user=database_user, passwd=database_password, db=database_db)
    # 获取系统时间作为上传时间
    now_time = datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')
    # 处理原始时间
    if time == '':
        time = now_time
    # 执行插入
    cursor = conn.cursor()
    # 判断是否已经存在该id的映射
    sql = "select * from faceidtoname where facename=\'" + faceName + '\' and userName=\'' + username + '\''
    flag_0 = cursor.execute(sql)
    # 如果不存在则插入映射
    if flag_0 == 0:
        sql1 = "insert into faceidtoname(userName,faceName,peopleName) values(%s,%s,%s)"
        cursor.execute(sql1, (username, faceName, "未命名"))
    # 然后插入照片
    flag = cursor.execute(
        "Insert into imgs(userName,Photo_time,upload_time,imgRoad,faceName,address,album) values(%s,%s,%s,%s,%s,%s,%s)",
        (username, time, now_time, imgName, faceName, img_address, album))
    conn.commit()
    cursor.close()
    conn.close()
    return flag


#  从数据库中读取照片
def select_imgs(username, flag):
    conn = pymysql.connect(host=database_host, user=database_user, passwd=database_password, db=database_db)
    cursor = conn.cursor()
    if flag == 1:
        sql = 'select imgRoad,Photo_time,id from imgs where userName=\'' + username + '\' ORDER BY Photo_time DESC'
    elif flag == 2:
        sql = 'select imgRoad,upload_time,id from imgs where DATE_SUB(CURDATE(), INTERVAL 7 DAY) <= date(upload_time) and userName=\'' + username + '\' ORDER BY Photo_time DESC;'
    else:
        sql = 'select imgRoad,Photo_time,id from imgs where userName=\'' + username + '\' ORDER BY Photo_time DESC'
    cursor.execute(sql)
    result = cursor.fetchall()
    cursor.close()
    conn.close()
    return result


#  对FaceName进行映射
def FaceNameToName(username, faceName):
    conn = pymysql.connect(host=database_host, user=database_user, passwd=database_password, db=database_db)
    cursor = conn.cursor()
    sql = 'select peopleName from faceidtoname where userName=\'' + username + '\' and faceName=\'' + faceName + '\''
    cursor.execute(sql)
    result = cursor.fetchone()
    cursor.close()
    conn.close()
    return result[0]


#  修改人物相册名字
def ReNamePeopleAlubmDataBase(username, faceName, newName):
    conn = pymysql.connect(host=database_host, user=database_user, passwd=database_password, db=database_db)
    cursor = conn.cursor()
    sql = 'update faceidtoname set peopleName=\'' + newName + '\'where faceName=\'' + faceName + '\''
    result = cursor.execute(sql)
    conn.commit()
    cursor.close()
    conn.close()
    return result


#  从数据库中删除照片
def delete_imgs(username, img_id):
    conn = pymysql.connect(host=database_host, user=database_user, passwd=database_password, db=database_db)
    cursor = conn.cursor()
    sql = 'DELETE FROM imgs where id=' + img_id + ' and userName=\'' + username + '\''
    print(sql)
    result = cursor.execute(sql)
    conn.commit()
    cursor.close()
    conn.close()
    return result


#  处理图片
def process_imgs(result, request, flag):
    data_dic = {}  # 图片、视频字典，key为日期，value为图片编号集合
    img_dic = {}  # 图片、视频字典，key为图片编号，value为图片
    url = request._get_scheme() + '://' + request.get_host()
    for item in result:
        #  处理日期
        date_obj = item[1]
        date_str = date_obj.strftime("%Y年%m月%d日")
        week_str = WEEK[date_obj.strftime("%A")]
        date_lable = date_str + " " + week_str

        # # 处理图片数据
        if flag == 1:
            image_data = item[0]
            img_road = url + settings.MEDIA_URL + 'images/' + image_data
        else:
            image_data = item[0]
            img_road = url + settings.MEDIA_URL + 'video/' + image_data

        num = item[2]

        if date_lable in data_dic.keys():
            data_dic[date_lable].append(num)
        else:
            data_dic[date_lable] = []
            data_dic[date_lable].append(num)

        if num in img_dic.keys():
            img_dic[num] = img_road
        else:
            img_dic[num] = ""
            img_dic[num] = img_road

    return data_dic, img_dic


#  首页 index
def index(request):
    try:
        name = request.session['userinfo']
        print("首页：username:" + name)
    except KeyError as e:
        return render(request, "loginModel/login.html")
    return render(request, "album/index.html", {"username": name})


#  欢迎界面
def welcome(request):
    return render(request, "album/welcome.html")


#  显示所有照片
def allphoto(request):
    try:
        username = request.session['userinfo']
        print("显示所有照片：username:" + username)
    except KeyError as e:
        return render(request, "loginModel/login.html")

    # 查询照片
    result = select_imgs(username, 1)  # flag=1为查询所有照片
    # 图片字典，key为日期，value为图片编号集合
    # 图片字典，key为图片编号，value为图片
    data_dic, img_dic = process_imgs(result, request, 1)
    return render(request, "album/allphoto.html", {'data_dic': data_dic, 'img_dic': img_dic})


#  打开上传界面
def upImg(request):
    return render(request, "album/upimg.html")


# 上传照片
def upload(request):
    if request.method == 'POST':

        # 从会话取出当前用户信息
        try:
            username = request.session['userinfo']
            print("上传照片：username:" + username)
        except KeyError as e:
            return render(request, "loginModel/login.html")

        file = request.FILES['file']

        # 使用uuid来给照片命名
        uuid_str = str(uuid.uuid1())
        img_road = uuid_str + '.jpg'

        save_path = '{}\\images\\{}'.format(settings.MEDIA_ROOT, img_road)
        sus_path = '{}\\suspend\\{}'.format(settings.MEDIA_ROOT, img_road)
        # print("sus_path", sus_path)
        # 保存照片到images媒体文件夹中
        with open(save_path, 'wb') as f:
            # 获取上传文件的内容， 并写到创建的文件中
            for content in file.chunks():  # pic.chunks文件内容
                f.write(content)

        # 保存缩略图
        with open(sus_path, 'wb') as f:
            # 获取上传文件的内容， 并写到创建的文件中
            for content in file.chunks():  # pic.chunks文件内容
                f.write(content)

        # 压缩照片
        while (os.path.getsize(sus_path)) > 2000000:
            sImg = Image.open(sus_path)
            w, h = sImg.size
            dImg = sImg.resize((int(w / 1.2), int(h / 1.2)), Image.ANTIALIAS)  # 设置压缩尺寸和选项，注意尺寸要用括号
            dImg.save(sus_path)

        # 通用图像识别
        res_str = imgrecognize.recognize(sus_path)
        print("res_str:", res_str)
        # 取通用图像识别结果的第一个识别结果
        res_list = res_str.split(',')
        # print('res_list[0]', res_list[0])

        # 人脸识别
        faceName = Add_face_to_person_photos.people_recognize(sus_path)
        if faceName == 1:
            print("No face detected")
            faceName = 'NoFace'
        elif faceName == 2:
            print("eCloud异常")
            faceName = 'NoFace'
        # 识别结果
        print('faceName:', faceName)

        # 获取照片信息
        Main = GetPhotoInfo(file)

        # 如果没有经纬度信息就不调用百度API,并将地址设置为其他
        if Main.lat == '' and Main.lon == '':
            Img_address = '其他'
        else:
            # 否则对经纬度信息进行逆地理编码转换
            Img_address = Main.get_location()
        print('Img_address:' + Img_address)
        # 插入图片（用户名，图片路径，时间，地址，分类结果，人脸信息）
        flag = insert_imgs(username, img_road, Main.time, Img_address, res_list[0], faceName)  # 插入照片
        print(flag)
        return JsonResponse({'code': '0'})


#  删除照片
def deleteImg(request):
    if request.method == 'POST':

        # 从会话取出当前用户信息
        try:
            username = request.session['userinfo']
            print("删除照片：username:" + username)
        except KeyError as e:
            return render(request, "loginModel/login.html")

        result = request.POST.get("result").split(',')
        print(result)
        res = 0
        for i in result:
            img_url = selectimgsById(username, i)
            img_url = settings.MEDIA_ROOT + "\\images\\" + img_url
            print(img_url)
            os.remove(img_url)
            res += delete_imgs(username, i)
        return HttpResponse(json.dumps(res))


#  最近上传
def recently(request):
    try:
        username = request.session['userinfo']
        print("最近上传：username:" + username)
    except KeyError as e:
        return render(request, "loginModel/login.html")

    # 查询照片
    result = select_imgs(username, 2)
    # 图片字典，key为日期，value为图片编号集合
    # 图片字典，key为图片编号，value为图片
    data_dic, img_dic = process_imgs(result, request, 1)
    return render(request, "album/recently.html", {'data_dic': data_dic, 'img_dic': img_dic})


#  统计相册
def count_albums(username, tag):
    conn = pymysql.connect(host=database_host, user=database_user, passwd=database_password, db=database_db)
    cursor = conn.cursor()
    if tag == 1:  # 统计相册
        sql = 'select album,count(*) as num from imgs where userName=\'' + username + '\' GROUP BY album'
    elif tag == 2:  # 按地点统计
        sql = 'select address,count(*) as num from imgs where userName=\'' + username + '\' and address!=\'其他\' GROUP BY address'
    elif tag == 3:  # 按faceName统计
        sql = 'select faceName,count(*) as num from imgs where userName=\'' + username + '\' and faceName !=\'NoFace\' GROUP BY faceName'
    else:
        sql = 'select album,count(*) as num from imgs where userName=\'' + username + '\' GROUP BY album'
    cursor.execute(sql)
    result = cursor.fetchall()
    cursor.close()
    conn.close()
    return result


#  查找相册的第一张照片
def selectFirstPhoto(album, flag, username):
    conn = pymysql.connect(host=database_host, user=database_user, passwd=database_password, db=database_db)
    cursor = conn.cursor()
    if flag == 1:  # 查找存在名字的相册
        sql = 'select imgRoad from imgs where userName=\'' + username + '\'' + 'and album=\'' + album + '\' limit 1'
    else:  # 其他相册
        sql = 'select imgRoad from imgs where album is NULL limit 1'
    cursor.execute(sql)
    result = cursor.fetchone()
    cursor.close()
    conn.close()
    return result[0]


# 查找地点的第一张照片
def selectFirstPhotoPlace(address, username):
    conn = pymysql.connect(host=database_host, user=database_user, passwd=database_password, db=database_db)
    cursor = conn.cursor()
    sql = 'select imgRoad from imgs where userName=\'' + username + '\'' + 'and address=\'' + address + '\' limit 1'
    cursor.execute(sql)
    result = cursor.fetchone()
    cursor.close()
    conn.close()
    return result[0]


#  查找人物的第一张照片
def selectFirstPhotoPeople(faceName, username):
    conn = pymysql.connect(host=database_host, user=database_user, passwd=database_password, db=database_db)
    cursor = conn.cursor()
    sql = 'select imgRoad from imgs where userName=\'' + username + '\'' + 'and faceName=\'' + faceName + '\' limit 1'
    cursor.execute(sql)
    result = cursor.fetchone()
    cursor.close()
    conn.close()
    return result[0]


#  相册
def photos(request):
    try:
        username = request.session['userinfo']
        print("相册：username:" + username)
    except KeyError as e:
        return render(request, "loginModel/login.html")
    result = count_albums(username, 1)
    img_num = {}  # 图片字典，key为album，value为num
    img_urls = {}  # 图片字典，key为album，value为url
    url = request._get_scheme() + '://' + request.get_host()
    for item in result:
        album = item[0]
        if album is not None:
            img_url = selectFirstPhoto(album, 1, username)
        else:
            img_url = selectFirstPhoto('', 0, username)
            album = '其他'
        num = item[1]
        img_url = url + settings.MEDIA_URL + 'images/' + img_url

        img_num[album] = ""
        img_num[album] = num

        img_urls[album] = ""
        img_urls[album] = img_url

    return render(request, "album/photos.html", {'img_num': img_num, 'img_urls': img_urls})


# 人物
def human(request):
    try:
        username = request.session['userinfo']
        print("人：username:" + username)
    except KeyError as e:
        return render(request, "loginModel/login.html")
    # 按照faceName进行统计
    result = count_albums(username, 3)
    img_num = {}  # 图片字典，key为album，value为num
    img_urls = {}  # 图片字典，key为album，value为url
    PEOPLE = {}
    url = request._get_scheme() + '://' + request.get_host()

    for item in result:
        faceName = item[0]
        # 查找该人脸第一张照片作为封面
        img_url = selectFirstPhotoPeople(faceName, username)
        # 给相册命名
        people_str = FaceNameToName(username, faceName)
        # faceName到相册名的映射
        PEOPLE[faceName] = ''
        PEOPLE[faceName] = people_str
        # 该faceName的数量
        num = item[1]
        img_url = url + settings.MEDIA_URL + 'images/' + img_url
        # faceName到该人脸数目的映射
        img_num[faceName] = ""
        img_num[faceName] = num

        img_urls[faceName] = ""
        img_urls[faceName] = img_url

    print('img_num', img_num)
    print('img_urls', img_urls)
    print('PEOPLE', PEOPLE)

    return render(request, "album/human.html", {'img_num': img_num, 'img_urls': img_urls, 'PEOPLE': PEOPLE})


# 地点
def place(request):
    try:
        username = request.session['userinfo']
        print("地点：username:" + username)
    except KeyError as e:
        return render(request, "loginModel/login.html")
    result = count_albums(username, 2)
    print("result", result)
    img_num = {}  # 图片字典，key为album，value为num
    img_urls = {}  # 图片字典，key为album，value为url
    url = request._get_scheme() + '://' + request.get_host()
    for item in result:
        address = item[0]
        img_url = selectFirstPhotoPlace(address, username)

        # 照片数量
        num = item[1]
        img_url = url + settings.MEDIA_URL + 'images/' + img_url

        if address in img_num.keys():
            img_num[address] = num
        else:
            img_num[address] = ""
            img_num[address] = num

        if address in img_urls.keys():
            img_urls[address] = img_url
        else:
            img_urls[address] = ""
            img_urls[address] = img_url

    return render(request, "album/place.html", {'img_num': img_num, 'img_urls': img_urls})


# 根据相册名查找相册具体内容
def toalbum_database(username, tag, flag):
    conn = pymysql.connect(host=database_host, user=database_user, passwd=database_password, db=database_db)
    cursor = conn.cursor()
    if flag == 1:
        # if tag == '其他':
        #     sql = 'select imgRoad,Photo_time,id from imgs where userName=\'' + username + '\' and album is null'
        # else:
        sql = 'select imgRoad,Photo_time,id from imgs where userName=\'' + username + '\' and album=\'' + tag + '\''
    elif flag == 2:
        sql = 'select imgRoad,Photo_time,id from imgs where userName=\'' + username + '\' and address=\'' + tag + '\''
    else:
        if tag == '其他':
            sql = 'select imgRoad,Photo_time,id from imgs where userName=\'' + username + '\' and faceName=\'\''
        else:
            sql = 'select imgRoad,Photo_time,id from imgs where userName=\'' + username + '\' and faceName=\'' + tag + '\''
    cursor.execute(sql)
    result = cursor.fetchall()
    cursor.close()
    conn.close()
    return result


# 进入相册
def toalbum(request):
    try:
        username = request.session['userinfo']
        print("进入相册：username:" + username)
    except KeyError as e:
        return render(request, "loginModel/login.html")

    img_tag = request.GET.get('img_tag')
    result = toalbum_database(username, img_tag, 1)
    data_dic, img_dic = process_imgs(result, request, 1)
    return render(request, "album/albumcontent.html", {'data_dic': data_dic, 'img_dic': img_dic, 'img_tag': img_tag})


# 进入地点相册
def addresstoalbum(request):
    try:
        username = request.session['userinfo']
        print("进入地点相册：username:" + username)
    except KeyError as e:
        return render(request, "loginModel/login.html")

    img_tag = request.GET.get('img_tag')
    result = toalbum_database(username, img_tag, 2)
    data_dic, img_dic = process_imgs(result, request, 1)
    return render(request, "album/albumcontent.html", {'data_dic': data_dic, 'img_dic': img_dic, 'img_tag': img_tag})


# 进入人物相册
def humantoalbum(request):
    try:
        username = request.session['userinfo']
        print("进入人物相册：username:" + username)
    except KeyError as e:
        return render(request, "loginModel/login.html")

    img_tag = request.GET.get('img_tag')
    people_tag = request.GET.get('people_tag')
    print("img_tag:", img_tag)
    print("people_tag:", people_tag)
    result = toalbum_database(username, img_tag, 3)
    data_dic, img_dic = process_imgs(result, request, 1)
    return render(request, "album/peoplecontent.html",
                  {'data_dic': data_dic, 'img_dic': img_dic, 'img_tag': people_tag, 'face_id': img_tag})


# 查看详情
def imgdetails(request):
    if request.method == 'POST':

        # 从会话取出当前用户信息
        try:
            username = request.session['userinfo']
            print("查看详情：username:" + username)
        except KeyError as e:
            return render(request, "loginModel/login.html")

        result = request.POST.get("result").split(',')
        print(result)
        return HttpResponse(json.dumps(result))


# 根据id查找图片
def selectimgsById(username, photo_id):
    conn = pymysql.connect(host=database_host, user=database_user, passwd=database_password, db=database_db)
    cursor = conn.cursor()
    sql = 'select imgRoad from imgs where id=' + photo_id + ' and userName=\'' + username + '\''
    cursor.execute(sql)
    result = cursor.fetchone()
    cursor.close()
    conn.close()
    return result[0]


# 选择音乐
def selectaudio(request):
    if request.method == 'POST':
        # 从会话取出当前用户信息
        try:
            username = request.session['userinfo']
            print("选择音乐：username:" + username)
        except KeyError as e:
            return render(request, "loginModel/login.html")
        result = request.POST.get("result").split(',')
        return HttpResponse(json.dumps(result))


# 从数据库中选择音频
def selectAudioFromDB(username):
    conn = pymysql.connect(host=database_host, user=database_user, passwd=database_password, db=database_db)
    cursor = conn.cursor()
    sql = 'select audioRoad,audioName,userName,id from audios where userName=\'' + username + '\'ORDER BY uploadTime DESC'
    cursor.execute(sql)
    result = cursor.fetchall()
    cursor.close()
    conn.close()
    return result


# 选择音乐界面
def selectaudiopage(request):
    # 从会话取出当前用户信息
    try:
        username = request.session['userinfo']
        print("选择音乐界面：username:" + username)
    except KeyError as e:
        return render(request, "loginModel/login.html")

    result = request.GET.get('result')
    print('result：', result)
    audio_urls = selectAudioFromDB(username)
    print("audio_urls:", audio_urls)
    audio_url_list = {}
    url = request._get_scheme() + '://' + request.get_host()
    for i in audio_urls:
        audio_url_list[i[1]] = ''
        audio_url_list[i[1]] = url + settings.MEDIA_URL + 'music/' + i[0]
    print(audio_url_list)
    return render(request, "album/audio.html", {'img_ids': result, 'audio_url_list': audio_url_list})


# 插入视频
def insertVideos(username, viedoUrl):
    # 获取系统时间作为上传时间
    now_time = datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')
    conn = pymysql.connect(host=database_host, user=database_user, passwd=database_password, db=database_db)
    # 执行插入
    cursor = conn.cursor()
    flag = cursor.execute(
        "Insert into videos(userName,viedoRoad,makeTime) values(%s,%s,%s)", (username, viedoUrl, now_time))
    conn.commit()
    cursor.close()
    conn.close()
    return flag


# 开始剪辑
def startmakevideo(request):
    if request.method == 'POST':
        # 从会话取出当前用户信息
        try:
            username = request.session['userinfo']
            print("开始剪辑：username:" + username)
        except KeyError as e:
            return render(request, "loginModel/login.html")

        img_ids = request.POST.get('img_ids')
        music_name = request.POST.get('music_name')
        img_ids_list = img_ids.split(',')
        print('img_ids_list:', img_ids_list)
        print('music_name:', music_name)

        imgurlList = []
        for i in img_ids_list:
            imgulr = selectimgsById(username, i)
            imgurlList.append(imgulr)
        print('imgurlList:', imgurlList)
        mp3_url = settings.MEDIA_ROOT + "\\music\\" + music_name
        print("mp3_url:", mp3_url)
        # save_path = '{}\\images\\{}'.format(settings.MEDIA_ROOT, img_road)
        viedo_name = makemovies.makevideos(mp3_url, imgurlList)

        flag = insertVideos(username, viedo_name)
        print(flag)
        return HttpResponse(json.dumps(flag))


# 从数据库中选择视频
def select_videos(username):
    conn = pymysql.connect(host=database_host, user=database_user, passwd=database_password, db=database_db)
    cursor = conn.cursor()
    sql = 'select viedoRoad,makeTime,id from videos where userName=\'' + username + '\' ORDER BY makeTime DESC'

    print(sql)
    cursor.execute(sql)
    result = cursor.fetchall()
    cursor.close()
    conn.close()
    return result


# 视频
def videos(request):
    # 从会话取出当前用户信息
    try:
        username = request.session['userinfo']
        print("视频：username:" + username)
    except KeyError as e:
        return render(request, "loginModel/login.html")
    result = select_videos(username)
    data_dic, img_dic = process_imgs(result, request, 2)

    VIDEOS = {}
    video_index = 1
    for item in result:
        num = item[2]

        people_str = "视频" + str(video_index)
        video_index = video_index + 1

        VIDEOS[num] = ''
        VIDEOS[num] = people_str
    return render(request, "album/videos.html", {'data_dic': data_dic, 'img_dic': img_dic, 'VIDEOS': VIDEOS})


#  从数据库中删除视频
def delete_video(username, video_id):
    conn = pymysql.connect(host=database_host, user=database_user, passwd=database_password, db=database_db)
    cursor = conn.cursor()
    sql = 'DELETE FROM videos where id=' + video_id + ' and userName=\'' + username + '\''
    print(sql)
    result = cursor.execute(sql)
    conn.commit()
    cursor.close()
    conn.close()
    return result


# 删除视频
def deleteVideo(request):
    if request.method == 'POST':

        # 从会话取出当前用户信息
        try:
            username = request.session['userinfo']
            print("删除视频：username:" + username)
        except KeyError as e:
            return render(request, "loginModel/login.html")

        result = request.POST.get("result").split(',')
        print(result)
        res = 0
        for i in result:
            video_url = select_videosByid(i)[0][0]
            video_url = settings.MEDIA_ROOT + "\\video\\" + video_url
            os.remove(video_url)
            res += delete_video(username, i)
        return HttpResponse(json.dumps(res))


# 上传视频
def upVideo(request):
    return render(request, "album/upVideo.html")


# 上传视频函数
def uploadVideo(request):
    if request.method == 'POST':

        # 从会话取出当前用户信息
        try:
            username = request.session['userinfo']
            print("上传视频：username:" + username)
        except KeyError as e:
            return render(request, "loginModel/login.html")

        file = request.FILES['file']

        uuid_str = str(uuid.uuid1())
        video_road = uuid_str + file.name

        save_path = '{}\\video\\{}'.format(settings.MEDIA_ROOT, video_road)

        print("save_path", save_path)
        with open(save_path, 'wb') as f:
            # 获取上传文件的内容， 并写到创建的文件中
            for content in file.chunks():  # pic.chunks文件内容
                f.write(content)
        insertVideos(username, video_road)
        return JsonResponse({'code': '0'})


# 下载照片
def downLoadImgs(request):
    result = request.POST.get("result").split(',')
    print(result)
    downloadName = str(uuid.uuid1())
    save_path = '{}\\zips\\{}'.format(settings.MEDIA_ROOT, downloadName + '.zip')
    z = zipfile.ZipFile(save_path, 'w')
    print(save_path)
    for i in result:
        img_url_names = i.split('/')
        # print("img_url_names:", img_url_names)
        # print("img_url_names[-1]:", img_url_names[-1])
        img_zip_url = '{}\\images\\{}'.format(settings.MEDIA_ROOT, img_url_names[-1])
        print("img_zip_url:", img_zip_url)
        z.write(img_zip_url, arcname=img_url_names[-1])
    z.close()
    url = request._get_scheme() + '://' + request.get_host()
    zip_url = url + settings.MEDIA_URL + 'zips/' + downloadName + '.zip'
    print("zip:", zip_url)
    return HttpResponse(json.dumps(zip_url))


# 上传音频
def upAudio(request):
    return render(request, "album/upAudio.html")


# 插入音频到数据库中
def insertAudio(audioRoad, audioName, username):
    # 获取系统时间作为上传时间
    now_time = datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')
    conn = pymysql.connect(host=database_host, user=database_user, passwd=database_password, db=database_db)
    # 执行插入
    cursor = conn.cursor()
    dect_sql = 'select * from audios where audioName=\'' + audioName + '\''
    flag = cursor.execute(dect_sql)
    if flag != 0:
        return "-1"
    else:
        flag = cursor.execute(
            "Insert into audios(audioRoad,uploadTime,audioName,userName) values(%s,%s,%s,%s)",
            (audioRoad, now_time, audioName, username))
        conn.commit()
        cursor.close()
        conn.close()
        return flag


# 上传音频
def uploadAudio(request):
    if request.method == 'POST':

        # 从会话取出当前用户信息
        try:
            username = request.session['userinfo']
            print("上传视频：username:" + username)
        except KeyError as e:
            return render(request, "loginModel/login.html")

        file = request.FILES['file']

        uuid_str = str(uuid.uuid1())
        audio_road = file.name

        save_path = '{}\\music\\{}'.format(settings.MEDIA_ROOT, audio_road)

        print("save_path", save_path)
        with open(save_path, 'wb') as f:
            # 获取上传文件的内容， 并写到创建的文件中
            for content in file.chunks():  # pic.chunks文件内容
                f.write(content)
        flag = insertAudio(audio_road, file.name, username)
        return JsonResponse({'code': '0'})


# 查看照片详情
def intoimgdetails(request):
    # 从会话取出当前用户信息
    try:
        username = request.session['userinfo']
        print("查看照片详情：username:" + username)
    except KeyError as e:
        return render(request, "loginModel/login.html")

    img_ids = request.GET.get('res_str')
    print("img_ids:", img_ids)
    img_ids_list = img_ids.split(',')
    imgurlList = []
    url = request._get_scheme() + '://' + request.get_host()

    for i in img_ids_list:
        imgulr = selectimgsById(username, i)
        img_url = url + settings.MEDIA_URL + 'images/' + imgulr
        imgurlList.append(img_url)

    return render(request, "album/imgdetails.html", {'imgurlList': imgurlList})


# 查看音频
def audios(request):
    # 从会话取出当前用户信息
    try:
        username = request.session['userinfo']
        print("查看音频：username:" + username)
    except KeyError as e:
        return render(request, "loginModel/login.html")
    # 获取音频路径
    audio_urls = selectAudioFromDB(username)
    # [0]是路径，[1]是名称
    print("audio_urls:", audio_urls)
    audio_url_list = {}
    url = request._get_scheme() + '://' + request.get_host()
    for i in audio_urls:
        audio_url_list[i[1]] = ''
        audio_url_list[i[1]] = url + settings.MEDIA_URL + 'music/' + i[0]
    print(audio_url_list)
    # key是名称，value是路径
    return render(request, "album/audios.html", {'audio_url_list': audio_url_list})


# 从数据库删除音频
def deleteAudiosFromDB(username, audioName):
    conn = pymysql.connect(host=database_host, user=database_user, passwd=database_password, db=database_db)
    cursor = conn.cursor()
    sql = 'DELETE FROM audios where audioName=\'' + audioName + '\' and userName=\'' + username + '\''
    print(sql)
    result = cursor.execute(sql)
    conn.commit()
    cursor.close()
    conn.close()
    return result


# 删除音频
def deleteAudios(request):
    if request.method == 'POST':

        # 从会话取出当前用户信息
        try:
            username = request.session['userinfo']
            print("删除音频：username:" + username)
        except KeyError as e:
            return render(request, "loginModel/login.html")

        result = request.POST.get("music_name").split(',')
        print(result)
        res = 0
        for i in result:
            audio_url = settings.MEDIA_ROOT + "\\music\\" + i
            print(audio_url)
            os.remove(audio_url)
            res += deleteAudiosFromDB(username, i)
        return HttpResponse(json.dumps(res))


# 从数据库中根据id选择视频
def select_videosByid(id):
    conn = pymysql.connect(host=database_host, user=database_user, passwd=database_password, db=database_db)
    cursor = conn.cursor()
    sql = 'select viedoRoad from videos where id=' + id

    print(sql)
    cursor.execute(sql)
    result = cursor.fetchall()
    cursor.close()
    conn.close()
    return result


# 视频下载
def downLoadVideos(request):
    result = request.POST.get("result").split(',')
    print(result)
    if len(result) == 1:
        video_urls = select_videosByid(result[0])
        print(video_urls[0][0])
        url = request._get_scheme() + '://' + request.get_host()
        video_url = url + settings.MEDIA_URL + 'video/' + video_urls[0][0]
        return HttpResponse(json.dumps(video_url))
    else:
        # 生成压缩文件
        downloadName = str(uuid.uuid1())
        save_path = '{}\\zips\\{}'.format(settings.MEDIA_ROOT, downloadName + '.zip')
        z = zipfile.ZipFile(save_path, 'w')
        print(save_path)
        for i in result:
            # 获得视频路径
            video_urls = select_videosByid(i)
            # 视频路径拼接
            video_url = '{}\\video\\{}'.format(settings.MEDIA_ROOT, video_urls[0][0])
            print("video_url:", video_url)
            z.write(video_url, arcname=video_urls[0][0])
        z.close()
        url = request._get_scheme() + '://' + request.get_host()
        zip_url = url + settings.MEDIA_URL + 'zips/' + downloadName + '.zip'
        print("zip:", zip_url)
        return HttpResponse(json.dumps(zip_url))


# 从数据库中根据音乐名称选择音乐
def selectAudioByName(username, audioName):
    conn = pymysql.connect(host=database_host, user=database_user, passwd=database_password, db=database_db)
    cursor = conn.cursor()
    sql = 'select audioRoad from audios where userName=\'' + username + '\' and audioName=\'' + audioName + '\''
    cursor.execute(sql)
    result = cursor.fetchall()
    cursor.close()
    conn.close()
    return result


# 音频下载
def downLoadAudios(request):
    # 从会话取出当前用户信息
    try:
        username = request.session['userinfo']
        print("删除音频：username:" + username)
    except KeyError as e:
        return render(request, "loginModel/login.html")
    result = request.POST.get("result").split(',')
    print(result)
    if len(result) == 1:
        Audio_urls = selectAudioByName(username, result[0])
        url = request._get_scheme() + '://' + request.get_host()
        audio_url = url + settings.MEDIA_URL + 'music/' + Audio_urls[0][0]
        print(audio_url)
        return HttpResponse(json.dumps(audio_url))
    else:
        # 生成压缩文件
        downloadName = str(uuid.uuid1())
        save_path = '{}\\zips\\{}'.format(settings.MEDIA_ROOT, downloadName + '.zip')
        z = zipfile.ZipFile(save_path, 'w')
        print(save_path)
        for i in result:
            # 获得音频路径
            Audio_urls = selectAudioByName(username, i)
            # 视频路径拼接
            audio_url = '{}\\music\\{}'.format(settings.MEDIA_ROOT, Audio_urls[0][0])
            print("video_url:", audio_url)
            # print("Audio_urls[0][0]:", Audio_urls[0][0])
            z.write(audio_url, arcname=Audio_urls[0][0])
        z.close()
        url = request._get_scheme() + '://' + request.get_host()
        zip_url = url + settings.MEDIA_URL + 'zips/' + downloadName + '.zip'
        print("zip:", zip_url)
        return HttpResponse(json.dumps(zip_url))


# 进入照片搜索界面
def research(request):
    # 从会话取出当前用户信息
    try:
        username = request.session['userinfo']
        print("照片搜索：username:" + username)
    except KeyError as e:
        return render(request, "loginModel/login.html")

    # 对分类相册进行统计
    result = count_albums(username, 1)
    people_result = count_albums(username, 3)
    address_result = count_albums(username, 2)
    print("resule.length:", len(result))
    img_urls = {}  # 图片字典，key为album，value为url
    people_img_urls = {}
    address_img_urls = {}
    PEOPLE = {}
    url = request._get_scheme() + '://' + request.get_host()
    # ---------照片分类------------------------------------------------------------------
    # 如果类别大于5，则显示5个
    if len(result) > 5:
        for i in range(5):
            album = result[i][0]
            if album is not None:
                img_url = selectFirstPhoto(album, 1, username)
            else:
                # 如果类别为空，则设置为其他
                img_url = selectFirstPhoto('', 0, username)
                album = '其他'
            img_url = url + settings.MEDIA_URL + 'images/' + img_url
            # 类别名到照片的映射
            img_urls[album] = ""
            img_urls[album] = img_url
    # 如果类别小于5个 则全部显示
    else:
        for item in result:
            album = item[0]
            if album is not None:
                img_url = selectFirstPhoto(album, 1, username)
            else:
                # 如果类别为空，则设置为其他
                img_url = selectFirstPhoto('', 0, username)
                album = '其他'
            img_url = url + settings.MEDIA_URL + 'images/' + img_url
            # 类别名到照片的映射
            img_urls[album] = ""
            img_urls[album] = img_url

    # ---------人物分类-----------------------------------------------------------------
    # 如果类别大于5，则显示5个
    if len(people_result) > 5:
        for i in range(5):
            faceName = people_result[i][0]
            # 查找该人脸第一张照片作为封面
            img_url = selectFirstPhotoPeople(faceName, username)
            # 给相册命名
            people_str = FaceNameToName(username, faceName)
            # faceName到相册名的映射
            PEOPLE[faceName] = ''
            PEOPLE[faceName] = people_str

            img_url = url + settings.MEDIA_URL + 'images/' + img_url
            # faceName到照片的映射
            people_img_urls[faceName] = ""
            people_img_urls[faceName] = img_url
    # 如果类别小于5个 则全部显示
    else:
        for item in people_result:
            faceName = item[0]
            # 查找该人脸第一张照片作为封面
            img_url = selectFirstPhotoPeople(faceName, username)
            # 给相册命名
            people_str = FaceNameToName(username, faceName)
            # faceName到相册名的映射
            PEOPLE[faceName] = ''
            PEOPLE[faceName] = people_str

            img_url = url + settings.MEDIA_URL + 'images/' + img_url
            # faceName到照片的映射
            people_img_urls[faceName] = ""
            people_img_urls[faceName] = img_url

    # ---------地点分类-------------------------------------------------------------------
    # 如果类别大于5，则显示5个
    if len(address_result) > 5:
        for i in range(5):
            address = address_result[i][0]
            # 挑选第一张照片
            img_url = selectFirstPhotoPlace(address, username)
            img_url = url + settings.MEDIA_URL + 'images/' + img_url
            # 地点到照片的映射
            address_img_urls[address] = ""
            address_img_urls[address] = img_url
    # 如果类别小于三个 则全部显示
    else:
        for item in address_result:
            address = item[0]
            # 挑选第一张照片
            img_url = selectFirstPhotoPlace(address, username)
            img_url = url + settings.MEDIA_URL + 'images/' + img_url
            # 地点到照片的映射
            address_img_urls[address] = ""
            address_img_urls[address] = img_url

    print("img_urls:", img_urls)
    print("people_img_urls:", people_img_urls)
    print("address_img_urls:", address_img_urls)
    print("PEOPLE:", PEOPLE)
    return render(request, "album/researchPhoto.html",
                  {'img_urls': img_urls, 'people_img_urls': people_img_urls, 'address_img_urls': address_img_urls,
                   'PEOPLE': PEOPLE})


# 人物相册重命名
def ReNamePeopleAlbum(request):
    # 从会话取出当前用户信息
    try:
        username = request.session['userinfo']
        print("人物相册重命名：username:" + username)
    except KeyError as e:
        return render(request, "loginModel/login.html")
    faceid = request.POST.get('faceid')
    newName = request.POST.get('newName')
    flag = ReNamePeopleAlubmDataBase(username=username, faceName=faceid, newName=newName)
    print(flag)
    return HttpResponse(json.dumps(flag))


#  根据关键词在数据库搜索照片 返回照片url，名称
def selectFirstPhotoFromDB(username, keywords, album):
    conn = pymysql.connect(host=database_host, user=database_user, passwd=database_password, db=database_db)
    cursor = conn.cursor()
    if album == "分类":
        sql = 'select album from imgs where userName=\'' + username + '\'and album LIKE \'%' + keywords + '%\' GROUP BY album'
    elif album == "人像":
        sql = 'select faceName from faceidtoname where userName=\'' + username + '\'and peopleName LIKE \'%' + keywords + '%\''
    elif album == "地点":
        sql = 'select address from imgs where userName=\'' + username + '\'and address LIKE \'%' + keywords + '%\' GROUP BY address'
    else:
        sql = 'select album,count(*) as num from imgs where userName=\'' + username + '\'and album LIKE \'%' + keywords + '%\' GROUP BY album'
    cursor.execute(sql)
    result = cursor.fetchall()
    cursor.close()
    conn.close()
    return result


# 根据关键词搜索照片
def searchPhotosByKey(request):
    # 从会话取出当前用户信息
    try:
        username = request.session['userinfo']
        print("根据关键词搜索照片：username:" + username)
    except KeyError as e:
        return render(request, "loginModel/login.html")
    keyword = request.POST.get('keyword')
    print("keyword:", keyword)

    # 分类照片搜索
    img_results = selectFirstPhotoFromDB(username=username, keywords=keyword, album="分类")
    # 人像照片搜索
    people_img_results = selectFirstPhotoFromDB(username=username, keywords=keyword, album="人像")
    # 地点照片搜索
    address_img_results = selectFirstPhotoFromDB(username=username, keywords=keyword, album="地点")
    if len(img_results) == 0 and len(people_img_results) == 0 and len(address_img_results) == 0:
        return HttpResponse(json.dumps(0))
    else:
        return HttpResponse(json.dumps(1))


# 照片搜索结果
def PhotoSearchResult(request):
    # 从会话取出当前用户信息
    try:
        username = request.session['userinfo']
        print("照片搜索结果：username:" + username)
    except KeyError as e:
        return render(request, "loginModel/login.html")
    keyword = request.GET.get('keyword')
    print("keyword:", keyword)
    url = request._get_scheme() + '://' + request.get_host()

    # 分类照片处理
    img_results = selectFirstPhotoFromDB(username=username, keywords=keyword, album="分类")
    print("img_results:", img_results)
    img_urls = {}  # 图片字典，key为album，value为url

    for item in img_results:
        album = item[0]
        if album is not None:
            img_url = selectFirstPhoto(album, 1, username)
        else:
            # 如果类别为空，则设置为其他
            img_url = selectFirstPhoto('', 0, username)
            album = '其他'
        img_url = url + settings.MEDIA_URL + 'images/' + img_url
        # 类别名到照片的映射
        img_urls[album] = ""
        img_urls[album] = img_url
    print("img_urls:", img_urls)

    # 人像照片处理
    people_img_results = selectFirstPhotoFromDB(username=username, keywords=keyword, album="人像")
    print("people_img_results:", people_img_results)
    people_img_urls = {}
    PEOPLE = {}

    for item in people_img_results:
        faceName = item[0]
        # 查找该人脸第一张照片作为封面
        img_url = selectFirstPhotoPeople(faceName, username)
        # 给相册命名
        people_str = FaceNameToName(username, faceName)
        # faceName到相册名的映射
        PEOPLE[faceName] = ''
        PEOPLE[faceName] = people_str

        img_url = url + settings.MEDIA_URL + 'images/' + img_url
        # faceName到照片的映射
        people_img_urls[faceName] = ""
        people_img_urls[faceName] = img_url
    print("people_img_urls:", people_img_urls)

    # 地点照片处理
    address_img_results = selectFirstPhotoFromDB(username=username, keywords=keyword, album="地点")
    print("address_img_results:", address_img_results)
    address_img_urls = {}
    for item in address_img_results:
        address = item[0]
        # 挑选第一张照片
        img_url = selectFirstPhotoPlace(address, username)
        img_url = url + settings.MEDIA_URL + 'images/' + img_url
        # 地点到照片的映射
        address_img_urls[address] = ""
        address_img_urls[address] = img_url
    print("address_img_urls:", address_img_urls)

    return render(request, "album/searchResult.html",
                  {'img_urls': img_urls, 'people_img_urls': people_img_urls, 'address_img_urls': address_img_urls,
                   'PEOPLE': PEOPLE})


#  根据关键词在数据库查找共享用户
def selectUserFromDB(share_userName):
    conn = pymysql.connect(host=database_host, user=database_user, passwd=database_password, db=database_db)
    cursor = conn.cursor()
    sql = 'select userName from users where userName=\'' + share_userName + '\''
    cursor.execute(sql)
    result = cursor.fetchall()
    cursor.close()
    conn.close()
    return result


# 根据id查找照片全部数据
def selectimgInfosById(username, photo_id):
    conn = pymysql.connect(host=database_host, user=database_user, passwd=database_password, db=database_db)
    cursor = conn.cursor()
    sql = 'select Photo_time,address,faceName,album from imgs where id=' + photo_id + ' and userName=\'' + username + '\''
    cursor.execute(sql)
    result = cursor.fetchone()
    cursor.close()
    conn.close()
    return result


# 插入共享关系
def insertShareRelationship(userName, shareUserName, prePhotoUrl, sharePhotoUrl):
    conn = pymysql.connect(host=database_host, user=database_user, passwd=database_password, db=database_db)
    cursor = conn.cursor()
    sql = "insert into sharephotos(fromUserName,acceptUserName,fromImgRoad,acceptImgRoad) values(%s,%s,%s,%s)"
    # 然后插入照片
    flag = cursor.execute(sql, (userName, shareUserName, prePhotoUrl, sharePhotoUrl))
    conn.commit()
    cursor.close()
    conn.close()
    return flag


# 共享照片
def sharePhotos(request):
    # 从会话取出当前用户信息
    try:
        username = request.session['userinfo']
        print("共享照片：username:" + username)
    except KeyError as e:
        return render(request, "loginModel/login.html")

    share_userName = request.POST.get('shareUserName')
    img_ids = request.POST.get('result')
    print('share_userName:', share_userName)
    result = selectUserFromDB(share_userName)
    # 如果未找到 则返回0
    if len(result) == 0:
        return HttpResponse(json.dumps(0))
    else:
        # 如果用户名是自己 不能共享给自己
        if username == result[0][0]:
            return HttpResponse(json.dumps(1))
        else:
            # 如果找到则进行图像上传，分享
            print('img_ids:', img_ids)
            img_ids_list = img_ids.split(',')
            print("img_ids_list:", img_ids_list)
            for item in img_ids_list:
                print(item)
                img_url = selectimgsById(username=username, photo_id=item)
                print("img_url:", img_url)

                uuid_str = str(uuid.uuid1())
                new_img_name = uuid_str + '.jpg'
                pre_img_road = '{}\\images\\{}'.format(settings.MEDIA_ROOT, img_url)
                new_img_road = '{}\\images\\{}'.format(settings.MEDIA_ROOT, new_img_name)
                print("new_road:", new_img_road)
                pre_file = open(pre_img_road, 'rb')
                content = pre_file.read()
                # 保存照片到images媒体文件夹中
                with open(new_img_road, 'wb') as f:
                    f.write(content)
                pre_file.close()

                img_info = selectimgInfosById(username=username, photo_id=item)
                photo_time = img_info[0]
                address = img_info[1]
                faceName = img_info[2]
                album = img_info[3]
                # 插入照片
                flag = insert_imgs(share_userName, new_img_name, photo_time, address, album, faceName)  # 插入照片
                print("flag：", flag)

                # 建立共享关系
                flag1 = insertShareRelationship(userName=username, shareUserName=share_userName, prePhotoUrl=img_url,
                                                sharePhotoUrl=new_img_name)
            return HttpResponse(json.dumps('ok'))


# 查找共享关系
def selectShareRelationship(userName):
    conn = pymysql.connect(host=database_host, user=database_user, passwd=database_password, db=database_db)
    cursor = conn.cursor()
    sql = "select fromUserName,acceptImgRoad from sharephotos where acceptUserName=\'" + userName + '\''
    # 然后插入照片
    cursor.execute(sql)
    result = cursor.fetchall()
    cursor.close()
    conn.close()
    return result


# 查找共享关系
def selectImgIdByImgUrl(userName, img_url):
    conn = pymysql.connect(host=database_host, user=database_user, passwd=database_password, db=database_db)
    cursor = conn.cursor()
    sql = "select id from imgs where imgRoad=\'" + img_url + '\''
    # 然后插入照片
    cursor.execute(sql)
    result = cursor.fetchone()
    cursor.close()
    conn.close()
    return result


# 共享照片界面
def sharePhotoPages(request):
    # 从会话取出当前用户信息
    try:
        username = request.session['userinfo']
        print("共享照片界面：username:" + username)
    except KeyError as e:
        return render(request, "loginModel/login.html")
    result = selectShareRelationship(username)
    print("result:", result)
    Img_urls = {}
    Img_ids = {}
    url = request._get_scheme() + '://' + request.get_host()

    for item in result:
        img_url = url + settings.MEDIA_URL + 'images/' + item[1]
        img_id = selectImgIdByImgUrl(userName=username, img_url=item[1])
        # 根据username映射到id
        if item[0] in Img_ids.keys():
            Img_ids[item[0]].append(img_id[0])
        else:
            Img_ids[item[0]] = []
            Img_ids[item[0]].append(img_id[0])
        # 根据id映射到url
        Img_urls[img_id[0]] = img_url
    print("Img_urls:", Img_urls)
    print("Img_ids:", Img_ids)
    return render(request, "album/sharePhotoPages.html", {"Img_urls": Img_urls, "Img_ids": Img_ids})
