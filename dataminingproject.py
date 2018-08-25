from flask import Flask, render_template, flash, request, redirect, url_for, jsonify
from wtforms import Form, TextField, TextAreaField, validators, StringField, SubmitField
# from doc_similarity import cosine_sim 

import pymongo
import json
from pymongo import MongoClient
from pprint import pprint


# from params_extraction import fun


# App config.
DEBUG = True
app = Flask(__name__)
app.config.from_object(__name__)
app.config['SECRET_KEY'] = '7d441f27d441f27567d441f2b6176a'

@app.route("/", methods=['GET'])
def index():
    return render_template('index.html')

'''@app.route("/<doc_name>", methods=['GET'])
def doc(doc_name):
    # similarity = cosine_sim('a little bird', 'a little bird')
    client = MongoClient('localhost')
    db_name = 'eyhack'
    db = client[db_name]
    collection_name = 'usage'
    collection = db[collection_name]
    print(doc_name)
    cursor = collection.find({'Document name':doc_name})
    for document in cursor: 
      pprint(document)

    return render_template('doc.html', results = document, docName = doc_name)'''

'''@app.route("/results", methods=['GET'])
def index():
    res = fun("static/data/test1.pdf")
    return render_template('index.html', res = res, results = database())'''

@app.route("/product", methods=['GET'])
def product():
    return render_template('product.html')

@app.route("/customer", methods=['GET'])
def customer():
    return render_template('customer.html')



'''@app.route("/do", methods=['POST'])
def do():
    res = fun("static/data/test1.pdf")
    return render_template('index.html', res=res,results=do_results(json.loads(request.data)))'''

if __name__ == "__main__":
    app.run()