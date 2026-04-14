package config

import (
	"os"
	"strconv"
)

type Config struct {
	Port        string
	AppVersion  string
	HomeAddress string
	HomeToken   string
}

func Load() Config {
	port := os.Getenv("APP_PORT")
	if _, err := strconv.Atoi(port); err != nil {
		port = "3000"
	}

	version := os.Getenv("APP_VERSION")
	if version == "" {
		version = "0.0.3"
	}

	return Config{
		Port:        port,
		AppVersion:  version,
		HomeAddress: os.Getenv("HOME_ADDRESS"),
		HomeToken:   os.Getenv("HOME_TOKEN"),
	}
}
