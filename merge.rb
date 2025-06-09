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
    return arr.dup if arr.size <= 1

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

Benchmark.memory do |x|
  x.report("MergeSort") do
    start_time = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    sorter = MergeSort.new(arr)
    result = sorter.sort
    end_time = Process.clock_gettime(Process::CLOCK_MONOTONIC)

    duration_ms = (end_time - start_time) * 1000.0
    puts "\nTiempo de ejecución del algoritmo: #{duration_ms.round(3)} ms"
  end
end
