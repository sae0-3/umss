import time
import tracemalloc

def merge_sort(arr):
    if len(arr) <= 1:
        return arr.copy()

    mid = len(arr) // 2
    left = merge_sort(arr[:mid])
    right = merge_sort(arr[mid:])

    return merge(left, right)

def merge(left, right):
    if not left:
        return right.copy()
    if not right:
        return left.copy()

    if left[0] <= right[0]:
        return [left[0]] + merge(left[1:], right)
    else:
        return [right[0]] + merge(left, right[1:])

if __name__ == "__main__":
    with open("numeros.txt") as f:
        line = f.read().strip()
        arr = list(map(int, line.split(",")))

    tracemalloc.start()
    start = time.perf_counter()

    merge_sort(arr)

    end = time.perf_counter()
    current, peak = tracemalloc.get_traced_memory()
    tracemalloc.stop()

    # print(result)
    print(f"\nTiempo de ejecución del algoritmo: {(end - start)*1000:.3f} ms")
    print(f"Memoria actual usada: {current / 1024:.2f} KB")
    print(f"Memoria pico usada: {peak / 1024:.2f} KB")
