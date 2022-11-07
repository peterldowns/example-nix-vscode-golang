package demo

import (
	"fmt"
	"time"
)

func Now() string {
	t := time.Now()
	return t.Format("2006-01-02 03:04:05PM")
}

func Hello(name string) string {
	return fmt.Sprintf("Hello %s", name)
}

func Goodbye(name string) string {
	return fmt.Sprintf("Goodbye %s", name)
}
