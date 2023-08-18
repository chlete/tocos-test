from flask import Flask, jsonify

app = Flask(__name__)

# Define a static JSON response
user_data = [
    {'username': 'alex','tocos': 30},
    {'username': 'ben','tocos': 50},
    {'username': 'charles','tocos': 366}
]

@app.route('/user', methods=['GET'])
def get_user():
    return jsonify(user_data)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8300)
