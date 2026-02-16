from flask import Flask, jsonify, request

app = Flask(__name__)

orders = []

@app.route('/health')
def health():
    return jsonify({'status': 'healthy'})

@app.route('/orders', methods=['GET', 'POST'])
def handle_orders():
    if request.method == 'POST':
        order = request.get_json()
        orders.append(order)
        return jsonify(order), 201
    return jsonify(orders)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5002)
