require 'benchmark'
require 'objspace'

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


linea = File.read("numeros.txt")
arr = linea.strip.split(",").map(&:to_i)

puts "Arreglo general:"
p arr

GC.start
before_mem = ObjectSpace.memsize_of_all

resultado = nil
tiempo = Benchmark.realtime do
  sorter = MergeSort.new(arr)
  resultado = sorter.sort
end

GC.start
after_mem = ObjectSpace.memsize_of_all
mem_diff = after_mem - before_mem

puts "\nArreglo ordenado:"
p resultado

puts "\nTiempo de ejecución del algoritmo: #{tiempo.round(6)} segundos"
puts "Memoria estimada usada durante el algoritmo: #{(mem_diff.to_f / 1024).round(2)} KB"
