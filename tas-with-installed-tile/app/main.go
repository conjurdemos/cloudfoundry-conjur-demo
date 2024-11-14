package main

import (
	"fmt"
	"net/http"
	"os"
	"strings"

	log "github.com/sirupsen/logrus"
)

func main() {
	log.SetFormatter(&log.TextFormatter{DisableTimestamp: true, DisableLevelTruncation: true})
	log.SetLevel(log.DebugLevel)

	log.Infof("Environment:\n%s\n\n", strings.Join(os.Environ(), "\n"))

	http.HandleFunc("/", func(res http.ResponseWriter, req *http.Request) {
		log.Infof("Handling request\n")
		res.WriteHeader(200)

		var secret = "[envvar not found]"
		if secretValue, ok := os.LookupEnv("DEMO_SECRET"); ok {
			secret = secretValue
		}

		var anotherSecret = "[envvar not found]"
		if secretValue, ok := os.LookupEnv("ANOTHER_DEMO_SECRET"); ok {
			anotherSecret = secretValue
		}

		_, _ = fmt.Fprintf(res, `
<h1>Visit us @ www.conjur.org!</h1>
<p>App secret: %s</p>
<p>Another app secret: %s</p>
`, secret, anotherSecret)
		log.Infof("Handled request\n")
	})

	port := os.Getenv("PORT")
	if len(port) == 0 {
		port = "8080"
	}

	log.Infof("Listening at port %s...", port)
	err := http.ListenAndServe(":"+port, nil)
	if err != nil {
		log.Errorf("Server error: %s\n", err.Error())
		os.Exit(1)
	}
}
