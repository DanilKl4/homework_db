package main

import (
	"fmt"
	"net"
	"sync"
	"sort"
)

func worker(ports chan int, wg *sync.WaitGroup, address string, opened *[]int) {
	for p := range ports {
		conn, err := net.Dial("tcp", fmt.Sprintf("%s:%d", address, p))
		if err != nil {
			wg.Done()
			continue
		}
		conn.Close()
		*opened = append(*opened, p)
		wg.Done()
	}
}

func Scan(address string) []int {
	ports := make(chan int, 200)
	opened := make([]int, 0)
	wg := sync.WaitGroup{}

	for i := 0; i < cap(ports); i++ {
		go worker(ports, &wg, address, &opened)
	}

	for i := 1; i < 10000; i++ {
		wg.Add(1)
		ports <- i
	}

	wg.Wait()
	close(ports) 
	sort.Ints(opened)
	return opened
}

func main() {
	ports := Scan("127.0.0.1")
	for p := range ports {
		fmt.Println(p)
	}
}