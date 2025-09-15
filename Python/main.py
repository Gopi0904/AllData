# +   Addition         a + b
# -   Subtraction      a - b
# *   Multiplication   a * b
# /   Division         a / b
# %   Modulus          a % b
# **  Exponent         a ** b
# //  Floor Division   a // b


a = 20
b = 10
result = None

# +
result = a + b 
print("a + b : ",result)

# -
result = a - b
print("a - b :",result)

# *
result = a * b
print("a * b :",result)

# / 
# Output in always Float Value
result = a / b
print("a / b :",result)

result = b / a
print("b / a :",result)

# **
result = a ** b
print("a / b :", result)

result = b ** a
print("b / a :", result)

# //
# Output in Always int Value 
result = a // b
print("a // b : ", result)

result = b // a
print("b // a : ", result)

import math 

print(1234.23453)
print(math.floor(1234.23453))
print(math.ceil(1234.23453))
print(round(1235.23453))

# % modulus
a = 9
b = 2
print("a % b :", a % b)

