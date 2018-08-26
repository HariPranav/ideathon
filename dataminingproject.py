from flask import Flask, render_template, flash, request, redirect, url_for, jsonify
from wtforms import Form, TextField, TextAreaField, validators, StringField, SubmitField
# from doc_similarity import cosine_sim 

import json
from pprint import pprint

import csv

# from params_extraction import fun


#python function to search through csv

import sys

#input number you want to search
def searchprod(id):
    number = id
    file = "product_"+id+".csv";
    return file

def searchcust(id):
    numbers=id
    csv_file = csv.reader(open('data/test/Recom.csv', "rb"), delimiter=",")
    #loop through csv list
    for row in csv_file:
        #if current rows 2nd value is equal to input, print that row
        if numbers == row[0]:
             return row


# App config.
DEBUG = True
app = Flask(__name__)
app.config.from_object(__name__)
app.config['SECRET_KEY'] = '7d441f27d441f27567d441f2b6176a'

@app.route("/", methods=['GET'])
def index():
    return render_template('index.html')

@app.route("/stats", methods=['GET'])
def stats():
    return render_template('stats.html')

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


@app.route("/customers", methods=['GET'])
def customers():
    return render_template('customers.html')

@app.route("/customers/<id>", methods=['GET'])
def customerss_id(id):
    result = searchcust(id)
    print result
    result = json.dumps(result)
    '''return render_template('customers.html',value=result)
    '''
    return result

@app.route("/products", methods=['GET'])
def products():
    return render_template('products.html')



@app.route("/products/<id>", methods=['GET'])
def productss_id(id):
    print id;
    file = searchprod(id);
    csvfile = open('data/test/'+file, 'r')
    fieldnames = ("Rank","Segment")
    reader = csv.DictReader( csvfile, fieldnames)
    string = ''
    result = []
    for row in reader:
        result.append(row)
        print row
    print result
    result = json.dumps(result)
    return result

@app.route("/kypc/<id>", methods=['GET'])
def customers_id(id):
    result = searchcust(id)
    print result
    result = json.dumps(result)
    return json.dumps(result)
    
 
@app.route("/kyca/<id>", methods=['GET'])
def products_id(id):
    print id;
    file = searchprod(id);
    csvfile = open('data/test/'+file, 'r')
    fieldnames = ("Rank", "Age", "Region", "Month")
    reader = csv.DictReader( csvfile, fieldnames)
    string = ''
    result = []
    for row in reader:
        result.append(row)
        print row
    print result
    result = json.dumps(result)
    return json.dumps(result)


@app.route("/kyc", methods=['GET','POST'])
def do():
    #request.args['product_id']
    csvfile = open('data/test/Know your Customer.csv', 'r')
    fieldnames = ("Rank", "Product")
    reader = csv.DictReader( csvfile, fieldnames)
    string = ''
    result = []
    for row in reader:
        result.append(row)
        print row
    print result
    return json.dumps(result)

@app.route("/kyc1", methods=['GET','POST'])
def do1():
    csvfile = open('data/test/Know your Customer_1.csv', 'r')
    fieldnames = ("Customer ID","1","2","3","4","5")
    reader = csv.DictReader( csvfile, fieldnames)
    string = ''
    result = []
    for row in reader:
        result.append(row)
        print row
    print result
    return json.dumps(result)

@app.route("/kyp", methods=['GET','POST'])
def do2():
    csvfile = open('data/test/Know your Product.csv', 'r')
    fieldnames = ("Rank", "Age", "Region", "Month")
    reader = csv.DictReader( csvfile, fieldnames)
    string = ''
    result = []
    for row in reader:
        result.append(row)
        print row
    print result
    return json.dumps(result)

@app.route("/kyp1", methods=['GET','POST'])
def do3():
    csvfile = open('data/test/Know your Product_1.csv', 'r')
    fieldnames = ("Sku","1","2","3","4","5")
    reader = csv.DictReader( csvfile, fieldnames)
    string = ''
    result = []
    for row in reader:
        result.append(row)
        print row
    print result
    return json.dumps(result)


if __name__ == "__main__":
    app.run()