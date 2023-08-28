from django.urls import path

from . import views

app_name = 'album'
urlpatterns = [
    path('album/index/', views.index, name='index'),  # 首页
    path('album/welcome/', views.welcome, name='welcome'),  # 我的桌面-欢迎页
    path('album/allphoto/', views.allphoto, name='allphoto'),  # 所有照片
    path('album/recently/', views.recently, name='recently'),  # 最近上传
    path('album/photos/', views.photos, name='photos'),  # 相册
    path('album/toalbum/', views.toalbum, name='toalbum'),  # 进入相册
    path('album/human/', views.human, name='human'),  # 人物
    path('album/humantoalbum/', views.humantoalbum, name='humantoalbum'),  # 进入人物相册
    path('album/ReNamePeopleAlbum/', views.ReNamePeopleAlbum, name='ReNamePeopleAlbum'),  # 人物相册重命名
    path('album/place/', views.place, name='place'),  # 地点
    path('album/addresstoalbum/', views.addresstoalbum, name='addresstoalbum'),  # 进入地点相册
    path('album/deleteVideo/', views.deleteVideo, name='deleteVideo'),  # 删除视频

    path('album/videos/', views.videos, name='videos'),  # 视频

    path('album/selectaudio/', views.selectaudio, name='selectaudio'),  # 选择音乐
    path('album/selectaudiopage/', views.selectaudiopage, name='selectaudiopage'),  # 选择音乐页面
    path('album/startmakevideo/', views.startmakevideo, name='startmakevideo'),  # 制作视频
    path('album/upImg/', views.upImg, name='upImg'),  # 图片上传页面
    path('album/upload/', views.upload, name='upload'),  # 图片上传函数

    path('album/upVideo/', views.upVideo, name='upVideo'),  # 视频上传页面
    path('album/uploadVideo/', views.uploadVideo, name='uploadVideo'),  # 视频上传函数
    path('album/downLoadVideos/', views.downLoadVideos, name='downLoadVideos'),  # 视频下载

    path('album/deleteImg/', views.deleteImg, name='deleteImg'),  # 删除照片
    path('album/downLoadImgs/', views.downLoadImgs, name='downLoadImgs'),  # 下载照片

    path('album/upAudio/', views.upAudio, name='upAudio'),  # 音频上传页面
    path('album/uploadAudio/', views.uploadAudio, name='uploadAudio'),  # 音频上传函数
    path('album/downLoadAudios/', views.downLoadAudios, name='downLoadAudios'),  # 音频下载

    path('album/imgdetails/', views.imgdetails, name='imgdetails'),  # 照片轮播
    path('album/intoimgdetails/', views.intoimgdetails, name='intoimgdetails'),  # 进入照片轮播界面

    path('album/audios/', views.audios, name='audios'),  # 音频
    path('album/deleteAudios/', views.deleteAudios, name='deleteAudios'),  # 删除音频

    path('album/research/', views.research, name='research'),  # 照片搜索
    path('album/searchPhotosByKey/', views.searchPhotosByKey, name='searchPhotosByKey'),  # 根据关键词搜索照片
    path('album/PhotoSearchResult/', views.PhotoSearchResult, name='PhotoSearchResult'),  # 照片搜索结果

    path('album/sharePhotos/', views.sharePhotos, name='sharePhotos'),  # 照片搜索结果
    path('album/sharePhotoPages/', views.sharePhotoPages, name='sharePhotoPages'),  # 照片共享界面

]
