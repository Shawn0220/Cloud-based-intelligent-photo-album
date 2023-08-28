# @description：把照片合成视频。
import cv2
import uuid
from moviepy.editor import *
from pydub import AudioSegment
import os.path
import glob
import math
import librosa

# 处理图片
from cloudPhoto import settings

def process_image(img, min_side):
    size = img.shape
    h, w = size[0], size[1]
    scale = max(w, h) / float(min_side)
    new_w, new_h = int(w / scale), int(h / scale)
    resize_img = cv2.resize(img, (new_w, new_h))
    if new_w % 2 != 0 and new_h % 2 == 0:
        top, bottom, left, right = (min_side - new_h) / 2, (min_side - new_h) / 2, (min_side - new_w) / 2 + 1, (
                min_side - new_w) / 2
    elif new_h % 2 != 0 and new_w % 2 == 0:
        top, bottom, left, right = (min_side - new_h) / 2 + 1, (min_side - new_h) / 2, (min_side - new_w) / 2, (
                min_side - new_w) / 2
    elif new_h % 2 == 0 and new_w % 2 == 0:
        top, bottom, left, right = (min_side - new_h) / 2, (min_side - new_h) / 2, (min_side - new_w) / 2, (
                min_side - new_w) / 2
    else:
        top, bottom, left, right = (min_side - new_h) / 2 + 1, (min_side - new_h) / 2, (min_side - new_w) / 2 + 1, (
                min_side - new_w) / 2
    pad_img = cv2.copyMakeBorder(resize_img, int(top), int(bottom), int(left), int(right), cv2.BORDER_CONSTANT,
                                 value=[0, 0, 0])  # 从图像边界向上,下,左,右扩的像素数目
    return pad_img


def get_all_pic_shaped_into_file(pic_size, file_list):  # 压缩图片长宽的最短边长度
    for item in file_list:
        if item.endswith('.jpg') or item.endswith('.png'):
            # 找到路径中所有后缀名为.png的文件，可以更换为.jpg或其它
            tiem_path = settings.MEDIA_ROOT + "\\images\\" + item
            image = cv2.imread(tiem_path)
            img_new = process_image(image, pic_size)
            newpath = settings.MEDIA_ROOT + "\\de_imgs\\" + item  # 压缩后的图片文件夹
            print('newpath:', newpath)
            cv2.imwrite(newpath, img_new, [int(cv2.IMWRITE_PNG_COMPRESSION), 2])


# 自动化剪辑 输入图片路径的字典，保存的viedo路径，
def make_movie(mp3_path, file_list):
    fps = 0.5
    size = [720, 720]
    # AVI格式编码输出 XVID
    four_cc = cv2.VideoWriter_fourcc(*'mp4v')
    # 无声视频存储地址 sus_viedo文件夹内+唯一识别码
    save_path = settings.MEDIA_ROOT + '\\sus_video\\' + '%s.mp4' % str(uuid.uuid1())
    print(save_path)
    video_writer = cv2.VideoWriter(save_path, four_cc, float(fps), size)

    # 视频保存在当前目录下
    for item in file_list:
        if item.endswith('.jpg') or item.endswith('.png'):
            # 找到路径中所有后缀名为.png的文件，可以更换为.jpg或其它
            print("item:", item)
            item = settings.MEDIA_ROOT + "\\de_imgs\\" + item
            print("item:", item)

            img = cv2.imread(item)
            re_pics = cv2.resize(img, size, interpolation=cv2.INTER_CUBIC)  # 定尺寸
            if len(re_pics):
                video_writer.write(re_pics)

    video_writer.release()
    cv2.destroyAllWindows()

    # 读取生成的无声视频
    cap = cv2.VideoCapture(save_path)

    duration = 0
    if cap.isOpened():  # 当成功打开视频时cap.isOpened()返回True,否则返回False
        # get方法参数按顺序对应下表（从0开始编号)
        rate = cap.get(5)  # 帧速率
        FrameNumber = cap.get(7)  # 视频文件的帧数
        duration = FrameNumber / rate  # 帧速率/视频总帧数 是时间，除以60之后单位是分钟
        print('duration', duration)

    SECOND = 1000

    # 导入音频
    song = AudioSegment.from_mp3(mp3_path)
    
    
    finSound = AudioSegment.from_mp3(mp3_path)
    duration_this_sound = librosa.get_duration(filename=mp3_path)
    print (duration_this_sound)
    
    target_time=240
    
    if duration_this_sound < target_time:
        n = math.ceil(target_time/duration_this_sound)
        print("将循环" + str(n) + "次")
        '''    
        variable = locals()
        for i in range(n):
            variable['cnt'+str(i)] = i
            variable['addsound'+str(i)] = AudioSegment.from_mp3(mp3_path)
        for i in range(n-1):
            print ("拼接音频第")
            print(variable.get('cnt' + str(i)))
            finSound = finSound + variable.get('addSound' + str(i)) + AudioSegment.from_mp3(file2_name) + AudioSegment.from_mp3(file2_name)
            variable.get('addsound' + str(i+1)) = finSound + variable.get('addsound' + str(i))
        '''
        count = 0
        while (count < n-1):
            finSound = finSound + AudioSegment.from_mp3(mp3_path)
            count = count + 1
    song = finSound

    # 截取视频时长的音频
    song = song[0:duration * SECOND]

    newaudio_save_path = settings.MEDIA_ROOT + '\\sus_music\\' + '%s.mp3' % str(
        uuid.uuid1())  # 存储新的音频地址 图片文件夹内+cut_audio_path+识别码+.mp4

    song.export(newaudio_save_path)  # 导出新的音频

    audio = AudioFileClip(newaudio_save_path)

    viedo = VideoFileClip(save_path)
    viedo = viedo.set_audio(audio)
    movie_name = str(uuid.uuid1()) + '.mp4'
    movie_path = settings.MEDIA_ROOT + '\\video\\' + movie_name
    viedo.write_videofile(movie_path, fps=5)
    return movie_name


def makevideos(mp3_path, file_list):
    get_all_pic_shaped_into_file(720, file_list)
    return make_movie(mp3_path, file_list)
# # path 视频保存路径 file_list 图片路径字典
# path = "D:\\PycharmProgram\\test\\images"  # 图片文件夹
# file_list = os.listdir(path)
# makeviedos('D:\\PycharmProgram\\test\\music\\Pianoboy - The truth that you leave.MP3', file_list)
