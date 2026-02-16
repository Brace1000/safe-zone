#!/bin/bash

echo "🧪 Testing SafeZone Microservices"
echo "=================================="
echo ""

# Test Product Service
echo "Testing Product Service..."
cd services/product-service

if [ ! -d "venv" ]; then
    python3 -m venv venv
fi

source venv/bin/activate
pip install -q -r requirements.txt

python app.py > /dev/null 2>&1 &
PID=$!
sleep 2

echo "  Checking health endpoint..."
HEALTH=$(curl -s http://localhost:5001/health)
if echo "$HEALTH" | grep -q "healthy"; then
    echo "  ✅ Health check passed"
else
    echo "  ❌ Health check failed"
fi

echo "  Checking products endpoint..."
PRODUCTS=$(curl -s http://localhost:5001/products)
if echo "$PRODUCTS" | grep -q "Product 1"; then
    echo "  ✅ Products endpoint working"
else
    echo "  ❌ Products endpoint failed"
fi

kill $PID 2>/dev/null
deactivate
cd ../..

echo ""

# Test Order Service
echo "Testing Order Service..."
cd services/order-service

if [ ! -d "venv" ]; then
    python3 -m venv venv
fi

source venv/bin/activate
pip install -q -r requirements.txt

python app.py > /dev/null 2>&1 &
PID=$!
sleep 2

echo "  Checking health endpoint..."
HEALTH=$(curl -s http://localhost:5002/health)
if echo "$HEALTH" | grep -q "healthy"; then
    echo "  ✅ Health check passed"
else
    echo "  ❌ Health check failed"
fi

echo "  Checking orders endpoint..."
ORDERS=$(curl -s http://localhost:5002/orders)
if [ "$ORDERS" = "[]" ]; then
    echo "  ✅ Orders endpoint working"
else
    echo "  ❌ Orders endpoint failed"
fi

kill $PID 2>/dev/null
deactivate
cd ../..

echo ""
echo "✅ Microservices testing complete!"
