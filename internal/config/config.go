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
	AFDToken    string
	AFDUserID   string
	GPGSignKey  string
	UmamiUser   string
	UmamiPass   string
	UmamiSiteID string
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
		AFDToken:    os.Getenv("AFD_TOKEN"),
		AFDUserID:   os.Getenv("AFD_USERID"),
		GPGSignKey:  os.Getenv("GPG_SIGN_KEY"),
		UmamiUser:   os.Getenv("UMAMI_USER"),
		UmamiPass:   os.Getenv("UMAMI_PASSWORD"),
		UmamiSiteID: os.Getenv("UMAMI_SITE_ID"),
	}
}
