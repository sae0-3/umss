import random

x = int(input())
min_val = 1
max_val = x

numeros = [random.randint(min_val, max_val) for _ in range(x)]

with open("numeros.txt", "w") as f:
    f.write(",".join(map(str, numeros)))
