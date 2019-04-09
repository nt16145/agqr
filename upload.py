import os
import datetime
from pydrive.auth import GoogleAuth
from pydrive.drive import GoogleDrive
import json
import yaml

day = datetime.date.today()
print(day)
path = "/radio/file/tmp"

files = os.listdir(path)
print(type(files))  # <class 'list'>
print(files)

ran = len(files)

gauth = GoogleAuth(settings_file='settings.yaml')
gauth.CommandLineAuth()
drive = GoogleDrive(gauth)

print(ran)
for i in files:
    if ((str(day)in i) == True):
        print(i)
        f = drive.CreateFile({'title':str(i), 'mimeType': 'video/mp4'})
        f.SetContentFile(str(path) + '/' + str(i))
        f.Upload()
        exit()
