from flask import Flask, jsonify

app = Flask(__name__)

@app.route('/health')
def health():
    return jsonify({'status': 'healthy'})

@app.route('/products')
def get_products():
    products = [
        {'id': 1, 'name': 'Product 1', 'price': 99.99},
        {'id': 2, 'name': 'Product 2', 'price': 149.99}
    ]
    return jsonify(products)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5001)
