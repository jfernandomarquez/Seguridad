import pytesseract
import sys
import argparse
import requests
import urllib
from selenium import webdriver
import time
import urllib2
import shutil
from PIL import Image, ImageEnhance, ImageFilter
try:
    import Image
except ImportError:
    from PIL import Image
from subprocess import check_output
import os
import tempfile
import subprocess
from captcha_solver import CaptchaSolver

def ocr(path):
    temp = tempfile.NamedTemporaryFile(delete=False)

    process = subprocess.Popen(['tesseract', path, temp.name], stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    process.communicate()

    with open(temp.name + '.txt', 'r') as handle:
        contents = handle.read()

    os.remove(temp.name + '.txt')
    os.remove(temp.name)

    return contents


def resolve(path):
	check_output(['convert', path, '-resample', '100', path])
	return pytesseract.image_to_string(Image.open(path))

if __name__=="__main__":

	for num in range(1,200):		
		s = requests.Session()
		ur = 'http://helper.aligo.com.co:10000/captcha.php'
		response = s.get(ur, stream=True)
		with open('img2.jpg', 'wb') as out_file:
		    shutil.copyfileobj(response.raw, out_file)
		del response
		#urllib.urlretrieve("http://helper.aligo.com.co:10000/captcha.php", "mi_imagen.jpg")
		#argparser = argparse.ArgumentParser()
		#argparser.add_argument('path',help = 'Captcha file path')
		#args = argparser.parse_args()
		#path = args.path
		#print('Resolving Captcha')
		#captcha_text = resolve(path)
		captcha_text = resolve('img2.jpg')
		captcha_text_r=captcha_text.replace("n","h") 
		im = Image.open("img2.jpg")
		im = im.filter(ImageFilter.MedianFilter())
		enhancer = ImageEnhance.Contrast(im)
		im = enhancer.enhance(2)
		im = im.convert('1')
		im.save('img3.jpg')
		captcha_text2 = resolve('img3.jpg')
		#captcha_text2 = resolve(Image.open("img2.jpg").convert("RGB"), lang='eng')

		output = pytesseract.image_to_string(Image.open("img2.jpg").convert("RGB"), lang='eng')

		################
		stri = ocr('img2.jpg')
		################

		stri2=stri.replace("n","h") 
		stri3=stri2.replace("s", "5")
		stri3=stri3.replace("a", "d")
		stri3=stri3.replace("t", "f")

		#################



		#print('Extracted Text',captcha_text)		
		#r = requests.post('http://helper.aligo.com.co:10000', data=captcha_text)
		#print(r.content)
		#post_params = {'captcha': captcha_text}
		#data = urllib.urlencode(post_params)		
		#post_params = {'name' : 'hola' }
		#post_args = urllib.urlencode(post_params)
		#url = 'http://helper.aligo.com.co:10000/'
		#fp = urllib.urlopen(url, post_args)
		#soup = BeautifulSoup(fp)
		#r = requests.post(url, params = post_params)
		#req = urllib2.Request(url, data)
		re = s.post("http://helper.aligo.com.co:10000/",data= {'captcha': captcha_text_r})
		re2 = s.post("http://helper.aligo.com.co:10000/",data= {'captcha': captcha_text2})
		re3 = s.post("http://helper.aligo.com.co:10000/",data= {'captcha': output})
		re4 = s.post("http://helper.aligo.com.co:10000/",data= {'captcha': stri})
		re5 = s.post("http://helper.aligo.com.co:10000/",data= {'captcha': stri3})
		re6 = s.post("http://helper.aligo.com.co:10000/",data= {'captcha': stri2})
		re7 = s.post("http://helper.aligo.com.co:10000/",data= {'captcha': captcha_text})
		#response = urllib2.urlopen(req)
		#html = response.read()
		#print html
		print(stri2)
		print(stri3)
		print("################################")
		print(captcha_text_r)
		print(captcha_text2)
		print(output)
		print(stri)
		print(stri2)
		print(stri3)
		#print(re.content)
		re_content=re.content.split("<")
		re2_content=re2.content.split("<")
		re3_content=re3.content.split("<")
		re4_content=re4.content.split("<")
		re5_content=re4.content.split("<")
		re6_content=re4.content.split("<")
		re7_content=re4.content.split("<")
		print(re.content)
		print(re_content[0])
		print(re2_content[0])
		print(re3_content[0])
		print(re4_content[0])
		print(re5_content[0])
		print(re6_content[0])
		print(re7_content[0])
		#print(r.text)
		#html = r.content
		#print html
		#browser = webdriver.Firefox()
		#browser.implicitly_wait(5)
		#browser.get(url)
		#browser.find_element_by_name('captcha').send_keys(captcha_text)
		#browser.find_element_by_class_name('submit').click() 

		#print browser.page_source
		#browser.close()





