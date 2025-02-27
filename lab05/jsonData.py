import os
print("Current working directory:", os.getcwd())
os.chdir('d:\RDBMS\lab05')

import json

# 1. Parse the JSON data and print the store’s "name" and its "city" location.
with open("json.txt", 'r') as f:
    data = json.load(f)
    
print(f"Store Name:{data['store']['name']}")
print(f"City:{data['store']['location']['city']}")

# 2. Access and print the names and prices of all products in the "Electronics" department.

for department in data['store']['departments']:
    if department['name'] == "Electronics":
        for product in department['products']:
              print(f"Product Name: {product['name']}, Price: {product['price']}")
              
# 3. Extract and print the "brand" and "specifications" of the product with the name "Wire-
# less Mouse".    

for department in data['store']['departments']:
    for product in department['products']:
        if product['name'] == "Wireless Mouse":
            print(f"Brand: {product['brand']}, Specifications: {product['specifications']}")
    
     
# 4. Modify the "price" of the "Smartphone" product to 749.99 and print the updated JSON.    


for department in data['store']['departments']:
    for product in department['products']:
        if product['name'] == "Smartphone":
            product['price'] = 749.99
                    
print(json.dumps(data, indent=4))                    