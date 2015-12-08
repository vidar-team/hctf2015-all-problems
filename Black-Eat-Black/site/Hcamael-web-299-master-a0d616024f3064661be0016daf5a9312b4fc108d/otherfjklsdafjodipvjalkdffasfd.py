#!/usr/bin/env python
#-*- coding:utf-8 -*-

from PIL import Image, ImageDraw, ImageFont, ImageFilter
import random
import os
import json

def ceruser(info):
	filen = "./userHCTF/"+info['user']
	if checkuser(filen):
		try:
			cer = json.load(open(filen,"r"))
		except:
			return (0, "登录失败!")
		if ('user' and 'pass') not in cer or info['user'] != cer['user'] or info['pass'] != cer['pass']:
			return (0, "用户名或密码输入失败!")
		return (1, "登录成功")
	return (0, "用户名或密码输入失败!")
		

def adduser(info):
	data = {"user":info['user'], "pass":info['pass']}
	filen = "./userHCTF/"+info['user']
	if not checkuser(filen):
		try:
			json.dump(data, open(filen, "w"))
			os.mkdir("./static/upload/"+info['user'])
			return (1, "注册成功!")
		except:
			return (0, "注册失败!")
	else:
		return (0, "用户已存在!")

def checkuser(user):
	return os.path.isfile(user)

info = {"user":"请输入用户名!", "pass":"请输入密码!", "repass":"请再次输入密码!", "code":"请输入验证码!"}
def check(form, var):
	# 检查相应的变量是否都有
	for x in var:
		if x in form:
			# 检查变量是否为空
			if form[x] == "":
				return (0, info[x])
		else:
			return (0, info[x])
			
	# 检查两次密码是否相等
	if 'repass' in var:
		if form['pass'] != form['repass']:
			return (0, "两次密码不相等!")
	return (1, "")

numbers = ''.join(map(str, range(10)))
chars = ''.join((numbers))
def create_validate_code(
	size=(120, 30), 
	chars=chars, 
	mode="RGB", 
	bg_color=(255, 255, 255), 
	fg_color=(255, 0, 0), 
	font_size=18, 
	font_type="./static/fonts/micross.ttf", 
	length=4, 
	draw_points=True, 
	point_chance = 2): 
	'''''
	size: 图片的大小，格式（宽，高），默认为(120, 30)
	chars: 允许的字符集合，格式字符串
	mode: 图片模式，默认为RGB
 	bg_color: 背景颜色，默认为白色
	fg_color: 前景色，验证码字符颜色
 	font_size: 验证码字体大小
	font_type: 验证码字体，默认为 Monaco.ttf
	length: 验证码字符个数
	draw_points: 是否画干扰点
	point_chance: 干扰点出现的概率，大小范围[0, 50]
	''' 
 
	width, height = size 
	img = Image.new(mode, size, bg_color) # 创建图形 
	draw = ImageDraw.Draw(img) # 创建画笔 
 
	def get_chars(): 
		'''''生成给定长度的字符串，返回列表格式''' 
		return random.sample(chars, length) 
 
	def create_points(): 
		'''''绘制干扰点''' 
		chance = min(50, max(0, int(point_chance))) # 大小限制在[0, 50] 
		for w in xrange(width): 
			for h in xrange(height): 
				tmp = random.randint(0, 50) 
				if tmp > 50 - chance: 
					draw.point((w, h), fill=(0, 0, 0)) 
 
	def create_strs(): 
		'''''绘制验证码字符''' 
		c_chars = get_chars() 
		strs = '%s' % ''.join(c_chars) 
		font = ImageFont.truetype(font_type, font_size) 
		font_width, font_height = font.getsize(strs) 
		draw.text(((width - font_width) / 3, (height - font_height) / 4), 
		strs, font=font, fill=fg_color) 
		return strs 
 
	if draw_points: 
		create_points() 
		strs = create_strs() 
 
	# 图形扭曲参数 
	params = [1 - float(random.randint(1, 2)) / 100, 0, 0, 0, 1 - float(random.randint(1, 10)) / 100, float(random.randint(1, 2)) / 500, 0.001, float(random.randint(1, 2)) / 500 ] 
	img = img.transform(size, Image.PERSPECTIVE, params) # 创建扭曲 
	img = img.filter(ImageFilter.EDGE_ENHANCE_MORE) # 滤镜，边界加强（阈值更大） 
	return img,strs
