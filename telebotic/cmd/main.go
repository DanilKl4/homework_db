package main

import (
	"log"
	"github.com/DanilKlochkov/telebotic/pkg/db"
	"github.com/DanilKlochkov/telebotic/internal/repository"
	"github.com/DanilKlochkov/telebotic/internal/handler"
	"github.com/DanilKlochkov/telebotic/internal/app"
)

func main() {
	db, err := db.Init()
	if err != nil {
		log.Fatalf(err.Error())
	} 
	repo := repository.NewRepository(db)
	hand := handler.NewHandler(repo)
	app := app.NewApp(hand)
	app.Start()
}