package main

import (
	"os"

	"github.com/CAATHARSIS/qr-code-api/internal/config"
	"github.com/CAATHARSIS/qr-code-api/internal/database"
	"github.com/CAATHARSIS/qr-code-api/internal/logger"

	_ "github.com/lib/pq"
)

func main() {
	cfg := config.Load()

	log := logger.NewLogger("local")

	log.Info("starting qr-code-api", "env", "local")

	appDB, err := database.NewPostgresDB(cfg)
	if err != nil {
		log.Error("Failed to connect to database", "error", err)
		if err := appDB.Close(); err != nil {
			log.Error("Failed to close app db", "error", err)
		}
		os.Exit(1)
	}

}
