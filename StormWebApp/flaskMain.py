from flask import Flask, request, render_template
import json, pickle
from random import shuffle


app = Flask(__name__)
app.config['DEBUG'] = True

words = []
wordsLock = []

fps = " "

currentWord = "test"


@app.route("/")
def home():
	return render_template("main.html")

@app.route("/rand")
def random():
	# tempW = pickle.load(open("wordList", "rb"))
	tempW = []
	
	with open("jsonSave.txt", "r") as jsonFile:
		tempW = json.load(jsonFile)

	shuffle(tempW)

	fileWord = ""

	if(len(tempW) > 0):
		fileWord = tempW[0]
		valid = True
	else:
		fileWord = "NONE"
		valid = False

	pack = {"valid":valid, "word":fileWord}

	return json.dumps(pack)


@app.route("/clearWords")
def clearWords():

	blank = []
	with open("jsonSave.txt","w") as jsonFile:
		json.dump(blank, jsonFile)
	return "Words cleared"


@app.route("/submit/<URLword>")
def submit(URLword):
	# if request.method == 'POST':
	with open("jsonSave.txt", "r") as wordSave:
		wordsLock = json.load(wordSave)


	words.append(URLword)
	wordsLock.append(URLword)


	
	# pickle.dump(words, open("wordList", "wb+"))
	
	with open("jsonSave.txt","w") as jsonFile:
		json.dump(wordsLock, jsonFile)

	return render_template("main.html")

@app.route("/giveStat/<fr>")
def giveStat(fr):

	fps = fr
	with open("frameSave.txt","w") as textFile:
		textFile.write(fr)
	return str(fr)

@app.route("/stats")
def stats():
	f = " "
	with open("frameSave.txt", "r") as textFile:
		f = textFile.read();

	return str(f)

@app.route("/getList")
def getList():
	wordList = []
	with open("jsonSave.txt", "r") as wordSave:
		wordList = json.load(wordSave)
	return json.dumps(wordList)

@app.route("/manage")
def manage():
	return render_template("manage.html")

@app.route("/removeWord/<index>")
def removeWord(index):
	tempW = []
	with open("jsonSave.txt","r") as jsonFile:
		tempW = json.load(jsonFile)

	indNum = int(index)
	wordsLock = tempW
	if(indNum <= len(tempW)):
		tempW.pop(indNum)
		with open("jsonSave.txt","w") as jsonFile:
			json.dump(tempW, jsonFile)

	# return render_template("manage.html")
	return "word removed"





@app.route('/words')
def getWords():
	# file = open("newTest.txt", "r")
	# fileWord = file.read()
	# file.close()
	fileWord = ""
	valid = False
	if(len(words) > 0):
		valid = True
		fileWord = words[0]
		words.pop(0)
	else:
		fileWord = "NONE"
	pack = {"valid":valid, "word":fileWord}

	return json.dumps(pack)


def setup():

	# with open("jsonSave.txt","r") as jsonFile:
	# 	wordsLock = json.load(jsonFile)
	with open("jsonSave.txt","r") as jsonFile:
		tempW = json.load(jsonFile)
	

if __name__ == "__main__":
	setup()
	app.run(host= '0.0.0.0', threaded=True)