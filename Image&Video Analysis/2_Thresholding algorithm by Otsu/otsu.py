{\rtf1\ansi\ansicpg1252\cocoartf2513
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;}
{\*\expandedcolortbl;;}
\margl1440\margr1440\vieww10800\viewh8400\viewkind0
\pard\tx720\tx1440\tx2160\tx2880\tx3600\tx4320\tx5040\tx5760\tx6480\tx7200\tx7920\tx8640\pardirnatural\partightenfactor0

\f0\fs24 \cf0 import cv2\
from matplotlib import pyplot as plt\
\
img = cv2.imread('/Users/vitalij/Downloads/2_otsi/aluminium.png',0)\
\
ret, imgf = cv2.threshold(img, 0, 255, cv2.THRESH_BINARY+cv2.THRESH_OTSU)\
plt.figure(figsize = (8,12))\
plt.subplot(3,1,3), plt.imshow(imgf,cmap = 'gray')\
plt.title('Otsu thresholding'), plt.xticks([]), plt.yticks([])\
plt.imsave('/Users/vitalij/Downloads/2_otsi/aluminium_Otsu.png', imgf, cmap = 'gray')\
plt.show()\
print('Threshold value: ', ret)}