from flask import Flask, jsonify
from flask_cors import CORS
import mysql.connector
import os

app = Flask(__name__)
CORS(app)

def get_db_connection():
    connection = mysql.connector.connect(
        host=os.getenv('DB_HOST', 'localhost'),
        user=os.getenv('DB_USER', 'root'),
        password=os.getenv('DB_PASSWORD', 'rootpassword'),
        database=os.getenv('DB_NAME', 'urgentNews')
    )
    return connection

@app.route('/getUrgentNews', methods=['GET'])
def get_news():
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute('SELECT * FROM News')
    news_records = cursor.fetchall()
    cursor.close()
    conn.close()
    return jsonify(news_records)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
