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

    var m1, m2 runtime.MemStats
    runtime.ReadMemStats(&m1)
    start := time.Now()

    mergeSort(arr)

    duration := time.Since(start)
    runtime.ReadMemStats(&m2)

    usedAlloc := m2.Alloc - m1.Alloc
    totalAlloc := m2.TotalAlloc - m1.TotalAlloc

    // fmt.Println(result)

    fmt.Printf("\nTiempo de ejecución del algoritmo: %.3f ms\n", float64(duration.Microseconds())/1000)
    fmt.Printf("Memoria actual usada (Alloc): %d bytes (%.2f KB)\n", usedAlloc, float64(usedAlloc)/1024)
    fmt.Printf("Memoria total asignada (TotalAlloc): %d bytes (%.2f KB)\n", totalAlloc, float64(totalAlloc)/1024)
}
