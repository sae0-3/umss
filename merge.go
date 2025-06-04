package main

import (
    "fmt"
    "io/ioutil"
    "strconv"
    "strings"
    "time"
    "runtime"
)

func mergeSort(arr []int) []int {
    if len(arr) <= 1 {
        return arr
    }
    
    queue := make([][]int, len(arr))
    for i, x := range arr {
        queue[i] = []int{x}
    }
    
    for len(queue) > 1 {
        left := queue[0]
        right := queue[1]
        queue = append(queue[2:], merge(left, right))
    }
    
    return queue[0]
}

func merge(left, right []int) []int {
    result := make([]int, 0, len(left)+len(right))
    i, j := 0, 0
    
    for i < len(left) && j < len(right) {
        if left[i] <= right[j] {
            result = append(result, left[i])
            i++
        } else {
            result = append(result, right[j])
            j++
        }
    }
    
    result = append(result, left[i:]...)
    result = append(result, right[j:]...)
    return result
}

func main() {
    data, err := ioutil.ReadFile("numeros.txt")
    if err != nil {
        panic(err)
    }

    line := strings.TrimSpace(string(data))
    parts := strings.Split(line, ",")

    var arr []int
    for _, part := range parts {
        n, err := strconv.Atoi(part)    
        if err != nil {
            panic(err)
        }
        arr = append(arr, n)
    }

    fmt.Println("Arreglo general:")
    fmt.Println(arr)

    var m1, m2 runtime.MemStats
    runtime.ReadMemStats(&m1)
    start := time.Now()

    result := mergeSort(arr)

    duration := time.Since(start)
    runtime.ReadMemStats(&m2)
    usedMemory := m2.Alloc - m1.Alloc

    fmt.Println("\nArreglo ordenado:")
    fmt.Println(result)

    fmt.Printf("\nTiempo de ejecución del algoritmo: %.12f segundos\n", duration.Seconds())
    fmt.Printf("Memoria usada por el algoritmo: %d bytes (%.6f KB, %.6f MB)\n",
        usedMemory,
        float64(usedMemory)/1024,
        float64(usedMemory)/(1024*1024),
    )
}
