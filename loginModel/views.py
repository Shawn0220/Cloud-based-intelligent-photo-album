import json

from django.http import JsonResponse, HttpResponse
from django.shortcuts import render
import pymysql

# Create your views here.
database_host = 'localhost'
database_user = 'root'
database_password = '123456'
database_db = 'ecloudphoto'
# 登录
def login(request):
    return render(request, "loginModel/login.html")


# 登录验证——数据库
def login_identify(username):
    # 连接数据库
    conn = pymysql.connect(host=database_host, user=database_user, passwd=database_password, db=database_db)
    cursor = conn.cursor()
    sql = "select * from users where userName=\'" + username + "\'"
    print(sql)
    cursor.execute(sql)
    row = cursor.fetchone()
    conn.commit()
    cursor.close()
    conn.close()
    return row


# 登录验证
def identify(request):
    if request.method == "POST":
        print(request.POST)

        name = request.POST.get("username")
        password = request.POST.get("password")
        print("username:" + name)
        print("password:" + password)

        row = login_identify(name)

        # 不存在该用户
        if row is None:
            return HttpResponse(json.dumps("该用户未注册！"))
        # 存在用户，进行密码匹配
        else:
            s_password = row[1]
            if password == s_password:
                request.session['userinfo'] = name
                return HttpResponse(json.dumps("yes"))
            else:
                return HttpResponse(json.dumps("密码错误！"))


# 退出
def log_out(request):
    # 登出 删除session中的记录
    sessionKey = request.session.session_key
    print("sessionKey:" + sessionKey)
    if sessionKey:
        request.session.delete(sessionKey)
    return render(request, "loginModel/login.html")


# 注册界面
def register(request):
    return render(request, "loginModel/register.html")


# 忘记密码
def resetpassword(request):
    return render(request, "loginModel/resetpassword.html")


# 注册写入数据库
def re_in(username, password, phone):
    conn = pymysql.connect(host=database_host, user=database_user, passwd=database_password, db=database_db)
    cursor = conn.cursor()
    flag = cursor.execute(
        "Insert into users(userName,passWord,phone) values(%s,%s,%s)", (username, password, phone))
    conn.commit()
    cursor.close()
    conn.close()
    return flag


# 注册（数据库）
def re_identify(username, phone):
    conn = pymysql.connect(host=database_host, user=database_user, passwd=database_password, db=database_db)
    cursor = conn.cursor()
    sql = 'select * from users where phone=\'' + phone + '\''  # 查询手机
    sql1 = 'select * from users where userName=\'' + username + '\''  # 查询用户名
    result = cursor.execute(sql)
    result1 = cursor.execute(sql1)
    conn.commit()
    cursor.close()
    conn.close()
    # 如果查询不为空，手机号未注册，则查看
    if result != 0:
        print(result)
        return 1  # "手机号已注册"
    # 如果查询不为空，账号未注册，则查看
    elif result1 != 0:
        print(result1)
        return 2  # "账号已注册"
    else:
        return 0  # '注册成功'


# 注册验证
def registerIdentify(request):
    if request.method == "POST":
        print(request.POST)

        name = request.POST.get("username")
        password = request.POST.get("password")
        phone = request.POST.get("phone")

        print("username:" + name)
        print("password:" + password)
        print("phone:" + phone)
        res = re_identify(name, phone)
        if res == 0:
            re_in(name, password, phone)
            return HttpResponse(json.dumps(res))
        return HttpResponse(json.dumps(res))


# 重置密码写入数据库
def reset_in(username, phone, password):
    conn = pymysql.connect(host=database_host, user=database_user, passwd=database_password, db=database_db)
    cursor = conn.cursor()
    sql = 'UPDATE users SET passWord=' + password + ' where userName=\'' + username + '\' and phone=\'' + phone + '\''
    flag = cursor.execute(sql)
    conn.commit()
    cursor.close()
    conn.close()
    return flag


# 重置验证（数据库）
def reset_identify(username, phone):
    conn = pymysql.connect(host=database_host, user=database_user, passwd=database_password, db=database_db)
    cursor = conn.cursor()
    sql = 'select * from users where phone=\'' + phone + '\''  # 查询手机
    sql1 = 'select * from users where userName=\'' + username + '\''  # 查询用户名
    sql2 = 'select * from users where userName=\'' + username + '\' and phone=\'' + phone + '\''  # 手机号和用户匹配
    result = cursor.execute(sql)
    result1 = cursor.execute(sql1)
    result2 = cursor.execute(sql2)
    conn.commit()
    cursor.close()
    conn.close()
    # 如果查询不为空，手机号未注册，则查看
    if result == 0:
        return 1  # "手机号未注册"
    # 如果查询不为空，账号未注册，则查看
    elif result1 == 0:
        return 2  # "用户名未注册"
    elif result2 == 0:
        return 3  # '用户名和手机号不匹配'
    else:
        return 0


# 重置密码验证
def resetIdentify(request):
    if request.method == "POST":
        name = request.POST.get("username")
        password = request.POST.get("password")
        phone = request.POST.get("phone")

        print("username:" + name)
        print("password:" + password)
        print("phone:" + phone)
        res = reset_identify(name, phone)
        if res == 0:
            reset_in(name, phone, password)
            return HttpResponse(json.dumps(res))
        return HttpResponse(json.dumps(res))
