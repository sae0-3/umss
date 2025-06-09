require 'benchmark'
require 'objspace'
require 'benchmark/memory'

class MergeSort
  def initialize(arr)
    @arr = arr.dup
  end

  def sort
    merge_sort(@arr)
  end

  private

  def merge_sort(arr)
    return arr if arr.size <= 1
    mid = arr.size / 2
    left = merge_sort(arr[0...mid])
    right = merge_sort(arr[mid..-1])
    merge(left, right)
  end

  def merge(left, right)
    result = []
    until left.empty? || right.empty?
      result << (left.first <= right.first ? left.shift : right.shift)
    end
    result + left + right
  end
end

# Leer archivo
linea = File.read("numeros.txt")
arr = linea.strip.split(",").map(&:to_i)

# Medir tiempo de ejecución
tiempo = Benchmark.realtime do
  sorter = MergeSort.new(arr)
  sorter.sort
end

puts "\nTiempo de ejecución del algoritmo: #{tiempo.round(6)} segundos"
puts "\nReporte detallado de uso de memoria con benchmark-memory:"
Benchmark.memory do |x|
  x.report("Merge Sort") do
    sorter = MergeSort.new(arr)
    sorter.sort
  end
end
