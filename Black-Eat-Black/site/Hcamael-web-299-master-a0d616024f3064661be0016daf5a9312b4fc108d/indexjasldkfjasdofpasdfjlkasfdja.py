#!/usr/bin/env python
#-*- coding:utf-8 -*-

import StringIO
import otherfjklsdafjodipvjalkdffasfd as other
import os
import time
import string, random, hashlib
from flask import Flask
from flask import render_template
from flask import request
from flask import session
from flask import jsonify
from flask import abort
from flask import Response


app = Flask(__name__)
app.config['MAX_CONTENT_LENGTH'] = 200 * 1024
key = string.ascii_letters
#app.secret_key = 'A0Zr98j/3yX R~XHH!jmN]LWX/,?RT'
#app.debug=True

# 自定义404页面
@app.errorhandler(404)
def internal_error(error):
    return render_template('404.html'), 404

# 两个主页路由, 伪装成php
@app.route('/')
def index():
	return render_template('index.html')

@app.route('/index.php')
def index2():
	return render_template('index.html')

# 验证码获取
@app.route('/code')
def code():
	try:
		code_img,strs = other.create_validate_code() 
		buf = StringIO.StringIO() 
		code_img.save(buf,'JPEG',quality=70) 
		buf_str = buf.getvalue()
		h = {'Content-Type': 'image/jpeg'} 
		response = Response(buf_str, headers=h)
		#response = app.make_response(buf_str)  
		#response.headers['Content-Type'] = 'image/jpeg'  
		session['code'] = strs
		return response  
	except(Exception) as s:
		print s
		return 'Hacked by Hcamael', 404
 	
# 登录路由
@app.route('/login', methods=['POST', 'GET'])
def login():
	if request.method == 'GET':
		try:
			token = get_token()
			return render_template('login.html', token = token)
		except(Exception) s:
			print s
			return "Hacked by Hcamael", 404
	if request.method == 'POST':
		form_list = ('user', 'pass', 'code')
		f = request.form
		try:
			e, s = other.check(f, form_list)
		except(Exception) as s:
			print s
			return "Hacked by Hcamael", 404
		if not e:
			return jsonify(error=1, info=s)
		if f['code'] != session['code']:
			return jsonify(error=2, info="验证码输入错误!")
		try:
			if f['token'] != session['token']:
				return ""
		except:
			return ""
		try:
			ee, ss = other.ceruser(f)
		except(Exception) as s:
			print s
			return "Hacked by Hcamael", 404
		if ee:
			session['user'] = f['user']
			session['path'] = "./static/upload/"+f['user']
			return jsonify(error=0, info=ss)
		else:
			return jsonify(error=1, info=ss)
			
		
# 注册路由
@app.route('/register', methods=['POST', 'GET'])
def register():
	if request.method == 'GET':
		try:
			token = get_token()
			return render_template('register.html', token = token)
		except(Exception) as s:
			print s
			return "Hacked by Hcamael", 404
	if request.method == 'POST':
		# 需要接收的参数
		form_list = ('user', 'pass', 'repass', 'code')
		f = request.form
		try:
			e, s = other.check(f, form_list)
		except(Exception) as s:
			print s
			return "leisile!", 404
		if not e:
			return jsonify(error=1, info=s)
		if f['code'] != session['code']:
			return jsonify(error=2, info="验证码输入错误!")
		try:
			if f['token'] != session['token']:
				return ""
		except:
			return ""
		# 检查完成, 插入数据
		try:
			ee, ss = other.adduser(f)
		except(Exception) as s:
			print s
			return "lei!", 404
		if ee:	
			return jsonify(error=0, info=ss)
		else:
			return jsonify(error=1, info=ss)

# 退出登录
@app.route('/logout')
def logout():
	try:
		del session['user']
		del session['path']
		return "<script>self.location.href='/'</script>"
	except:
		return "<script>self.location.href='/'</script>"

# 用户主页
@app.route('/<name>')
def user(name):
	if 'user' not in session or name != session['user']:
		abort(404)
	if 'path' not in session or not os.path.isdir(session['path']):
		abort(404)
	data = {}
	try:
		token = get_token()
		dire = "static/upload/" + name + "/"
		data = file_info(dire)
		return render_template('user.html',name=name ,data = data, token=token)
	except(Exception) as s:
		print s
		return "leileilei!", 404

# 查看文件
@app.route('/<name>/uploadfile/<path:filename>')
def filen(name, filename):
	if 'user' not in session or name != session['user']:
		abort(404)
	if 'path' not in session or not os.path.isdir(session['path']):
		abort(404)
	try:
		with open("./static/upload/%s/%s" % (name, filename), "rb") as f:
			content=f.read()
	except:
		return ""
	return content
# 文件上传
@app.route('/<name>/upload', methods=['POST',])
def upload(name):
	if 'user' not in session or name != session['user']:
		abort(404)
	if 'path' not in session or not os.path.isdir(session['path']):
		abort(404)
	if request.method == 'POST':
		try:
			if request.form['code'] != session['code']:
				return "<script>alert('验证码错误!');history.back();</script>"
			if request.form['token'] != session['token']:
				return ""
		except:
			return "1"
		
		f = request.files['file']
		try:
			f.save("./static/upload/%s"%name+"/"+f.filename)
		except:
			return "<script>alert('Upload Fail!');history.back();</script>"	
		return "<script>alert('Upload Success!');history.back();</script>"
	else:
		return "2"

# 获取用户文件信息
def file_info(dire):
	data = {}
	fi = os.listdir(dire)
	for x in range(len(fi)):
		data[x] = {}
		data[x]['name'] = fi[x]
		size = os.path.getsize(dire+fi[x])
		ctime = os.path.getctime(dire+fi[x])
		atime = os.path.getatime(dire+fi[x])
		data[x]['size'] = size
		ctime = time.strftime('%Y-%m-%d %H:%M:%S',time.localtime(ctime))
		atime = time.strftime('%Y-%m-%d %H:%M:%S',time.localtime(atime))
		data[x]['ctime'] = ctime
		data[x]['atime'] = atime
	return data
		

# csrf_token生成
def get_token():
	token = "".join(x for x in random.sample(key,7))
	token = hashlib.md5(token).hexdigest()
	session['token'] = token
	return token


if __name__ == '__main__':
	app.secret_key = 'A0Zr98j/3yX R~XHH!jmN]LWX/,?RT'
	app.run(debug=True, host="127.0.0.1", port=11111, threaded=True)
