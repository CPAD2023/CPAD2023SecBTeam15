package main

import (
	_ "github.com/lib/pq"
	"log"
	"main/pkg/routers"
	"net/http"
)

func main() {
	log.Println("Server started")
	log.Fatal(http.ListenAndServe(":8080", routers.CreateMuxRouter()))
}
