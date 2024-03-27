#!/bin/bash

total_tests=0
passed_tests=0
failed_tests=0

test_endpoint() {
    method=$1
    url=$2
    expected_status=$3

    echo "Testowanie $method $url, oczekiwany status: $expected_status"

    status_code=$(curl -o /dev/null -s -w "%{http_code}\n" -X "$method" "$url")

    if [ "$status_code" -eq "$expected_status" ]; then
        echo "Test $method $url powiódł się"
        ((passed_tests++))
    else
        echo "Test $method $url nie powiódł się, otrzymano status: $status_code"
        ((failed_tests++))
    fi

    ((total_tests++))
    echo
}

test_endpoint GET "http://localhost:8000/product/" 200
test_endpoint POST "http://localhost:8000/product/new" 200
test_endpoint GET "http://localhost:8000/product/2" 200
test_endpoint GET "http://localhost:8000/product/2/edit" 200
test_endpoint POST "http://localhost:8000/product/delete/1" 404

test_endpoint GET "http://localhost:8000/category/" 200
test_endpoint POST "http://localhost:8000/category/category/new" 200
test_endpoint GET "http://localhost:8000/category/category/3" 200
test_endpoint GET "http://localhost:8000/category/category/3/edit" 200
test_endpoint POST "http://localhost:8000/category/delete/1" 404

test_endpoint GET "http://localhost:8000/supplier/" 200
test_endpoint POST "http://localhost:8000/supplier/supplier/new" 200
test_endpoint GET "http://localhost:8000/supplier/supplier/2" 200
test_endpoint GET "http://localhost:8000/supplier/supplier/2/edit" 200
test_endpoint POST "http://localhost:8000/supplier/supplier/delete/1" 404

echo "Podsumowanie testów:"
echo "Całkowita liczba testów: $total_tests"
echo "Testy zakończone powodzeniem: $passed_tests"
echo "Testy zakończone niepowodzeniem: $failed_tests"

if [ "$total_tests" -eq "$passed_tests" ]; then
    echo "Wszystkie testy zakończyły się sukcesem!"
    exit 0
else
    echo "Niektóre testy nie przeszły pomyślnie."
    exit 1
fi
