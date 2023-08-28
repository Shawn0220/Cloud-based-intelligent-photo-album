from django.urls import path

from . import views

app_name = 'loginModel'
urlpatterns = [
    path('loginModel/login/', views.login, name='login'),  # ��¼
    path('loginModel/identify/', views.identify, name='identify'),  # ��¼��֤
    path('loginModel/log_out/', views.log_out, name='log_out'),  # ��¼��֤
    path('loginModel/register/', views.register, name='register'),  # ע��
    path('loginModel/resetpassword/', views.resetpassword, name='resetpassword'),  # ��������
    path('loginModel/registerIdentify/', views.registerIdentify, name='registerIdentify'),  # ע����Ϣ��֤
    path('loginModel/resetIdentify/', views.resetIdentify, name='resetIdentify'),  # ע����Ϣ��֤
]
