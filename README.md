# learningMV
1. test1: 简单的读取图像，数东西，halcon
2. test1: 简单的读取图像，找圆,halcon
3. test3: 模板匹配实验,halcon
4. test4: OCR实验,halcon
5. test5: ICpin测量,halcon
6. calib+mv:标定相关 
7. 二维码识别:例子中 qrcode_simple.hev
8. 一维码识别： try_to_find_bar_code，find_bar_code
9. 从园和矩形中获得物体的3维形状 get_circle_pose,get_rectangle_pose，get_rectangle_pose_barcode.hdev
10. 药丸检测checkBlister,线detect_mura_defects_blur
11. 光流 optic_flow optical_flow_mg   
12. testA1:实时检测二维码和一维码。基于了例子qrcode_simple.hev，以及一维码函数try_to_find_bar_code，find_bar_code和帮助
13. testA2: Tesseract OCR 和 ZXing-bar-qr 库实现OCR 和条码二维码识别
14. testA3: 测量直线曲线长度
15. testA4: 实时检测矩形和原型姿态

halcon19，20在OCR方面引入深度学习效果非常好，现有的OCR可以不用了  
halcon在异常物体检测上面引入深度学习，通过少量正样本，异常检测更好了。如果不看细节，现有的表面缺陷检测可以不用了。  
halcon在3D物体检测和测量上非常强，在应用上可以算第一。但是，本课程没有讲，请注意。  
