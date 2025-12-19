import pandas as pd
import matplotlib.pyplot as plt

df = pd.read_csv("resultados.csv")
df = df.dropna()
grouped = df.groupby(['lenguaje', 'tamaño_input']).mean(numeric_only=True).reset_index()

plt.figure(figsize=(10, 6))
for lang in grouped['lenguaje'].unique():
    subset = grouped[grouped['lenguaje'] == lang]
    plt.plot(subset['tamaño_input'], subset['tiempo_ms'], label=lang, marker='o')

plt.title("Tiempo promedio de ejecución de Merge Sort")
plt.xlabel("Tamaño del input")
plt.ylabel("Tiempo promedio (ms)")
plt.legend()
plt.grid(True)
plt.tight_layout()
plt.savefig("tiempo_promedio_merge_sort.png")
plt.show()

plt.figure(figsize=(10, 6))
for lang in grouped['lenguaje'].unique():
    subset = grouped[grouped['lenguaje'] == lang]
    plt.plot(subset['tamaño_input'], subset['memoria_kb'], label=lang, marker='s')

plt.title("Uso promedio de memoria de Merge Sort")
plt.xlabel("Tamaño del input")
plt.ylabel("Memoria promedio (KB)")
plt.legend()
plt.grid(True)
plt.tight_layout()
plt.savefig("memoria_promedio_merge_sort.png")
plt.show()
