
from flask import Flask
from my_blueprint import my_blueprint

#Define flask app
app = Flask(__name__)

#load blueprints
app.register_blueprint(my_blueprint,url_prefix='/demo')

#start flask
if __name__ == '__main__':
    app.run(host='127.0.0.1',port=5006, debug=False)
