from django.urls import path

from . import views

app_name = 'loginModel'
urlpatterns = [
    path('loginModel/login/', views.login, name='login'),  # 登录
    path('loginModel/identify/', views.identify, name='identify'),  # 登录验证
    path('loginModel/log_out/', views.log_out, name='log_out'),  # 登录验证
    path('loginModel/register/', views.register, name='register'),  # 注册
    path('loginModel/resetpassword/', views.resetpassword, name='resetpassword'),  # 忘记密码
    path('loginModel/registerIdentify/', views.registerIdentify, name='registerIdentify'),  # 注册信息验证
    path('loginModel/resetIdentify/', views.resetIdentify, name='resetIdentify'),  # 注册信息验证
]
