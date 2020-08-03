package main

import (
	"log"
	"net/http"
	"os"
)

func HiHandler(w http.ResponseWriter, req *http.Request) {
    w.Header().Set("Content-Type", "text/plain")
    w.Write([]byte("Hello, world!\n"))
}

func main() {
	var certfile string
	if len(os.Args) == 1 {
		certfile = "server.crt"
	} else {
		certfile = os.Args[1]
	}
	http.HandleFunc("/hi", HiHandler)
	err := http.ListenAndServeTLS(":443", certfile, "server.key", nil)
	if err != nil {
		log.Fatal(err)
	}
}
