from django.urls import path

from . import views

app_name = 'album'
urlpatterns = [
    path('album/index/', views.index, name='index'),  # ��ҳ
    path('album/welcome/', views.welcome, name='welcome'),  # �ҵ�����-��ӭҳ
    path('album/allphoto/', views.allphoto, name='allphoto'),  # ������Ƭ
    path('album/recently/', views.recently, name='recently'),  # ����ϴ�
    path('album/photos/', views.photos, name='photos'),  # ���
    path('album/toalbum/', views.toalbum, name='toalbum'),  # �������
    path('album/human/', views.human, name='human'),  # ����
    path('album/humantoalbum/', views.humantoalbum, name='humantoalbum'),  # �����������
    path('album/ReNamePeopleAlbum/', views.ReNamePeopleAlbum, name='ReNamePeopleAlbum'),  # �������������
    path('album/place/', views.place, name='place'),  # �ص�
    path('album/addresstoalbum/', views.addresstoalbum, name='addresstoalbum'),  # ����ص����
    path('album/deleteVideo/', views.deleteVideo, name='deleteVideo'),  # ɾ����Ƶ

    path('album/videos/', views.videos, name='videos'),  # ��Ƶ

    path('album/selectaudio/', views.selectaudio, name='selectaudio'),  # ѡ������
    path('album/selectaudiopage/', views.selectaudiopage, name='selectaudiopage'),  # ѡ������ҳ��
    path('album/startmakevideo/', views.startmakevideo, name='startmakevideo'),  # ������Ƶ
    path('album/upImg/', views.upImg, name='upImg'),  # ͼƬ�ϴ�ҳ��
    path('album/upload/', views.upload, name='upload'),  # ͼƬ�ϴ�����

    path('album/upVideo/', views.upVideo, name='upVideo'),  # ��Ƶ�ϴ�ҳ��
    path('album/uploadVideo/', views.uploadVideo, name='uploadVideo'),  # ��Ƶ�ϴ�����
    path('album/downLoadVideos/', views.downLoadVideos, name='downLoadVideos'),  # ��Ƶ����

    path('album/deleteImg/', views.deleteImg, name='deleteImg'),  # ɾ����Ƭ
    path('album/downLoadImgs/', views.downLoadImgs, name='downLoadImgs'),  # ������Ƭ

    path('album/upAudio/', views.upAudio, name='upAudio'),  # ��Ƶ�ϴ�ҳ��
    path('album/uploadAudio/', views.uploadAudio, name='uploadAudio'),  # ��Ƶ�ϴ�����
    path('album/downLoadAudios/', views.downLoadAudios, name='downLoadAudios'),  # ��Ƶ����

    path('album/imgdetails/', views.imgdetails, name='imgdetails'),  # ��Ƭ�ֲ�
    path('album/intoimgdetails/', views.intoimgdetails, name='intoimgdetails'),  # ������Ƭ�ֲ�����

    path('album/audios/', views.audios, name='audios'),  # ��Ƶ
    path('album/deleteAudios/', views.deleteAudios, name='deleteAudios'),  # ɾ����Ƶ

    path('album/research/', views.research, name='research'),  # ��Ƭ����
    path('album/searchPhotosByKey/', views.searchPhotosByKey, name='searchPhotosByKey'),  # ���ݹؼ���������Ƭ
    path('album/PhotoSearchResult/', views.PhotoSearchResult, name='PhotoSearchResult'),  # ��Ƭ�������

    path('album/sharePhotos/', views.sharePhotos, name='sharePhotos'),  # ��Ƭ�������
    path('album/sharePhotoPages/', views.sharePhotoPages, name='sharePhotoPages'),  # ��Ƭ�������

]
