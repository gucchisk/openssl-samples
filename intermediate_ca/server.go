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
		certfile = "certs/server_bundled.crt"
	} else {
		certfile = os.Args[1]
	}
	http.HandleFunc("/hi", HiHandler)
	err := http.ListenAndServeTLS(":443", certfile, "keys/server.key", nil)
	if err != nil {
		log.Fatal(err)
	}
}
