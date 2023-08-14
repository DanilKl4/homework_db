package main

import (
	"os"

	"github.com/DanilKlochkov/homework_db/console_game/game"
	"github.com/DanilKlochkov/homework_db/console_game/models"
)

func main() {
	p := models.NewPlayer()
	g := game.NewGame(p, os.Stdin, os.Stdout)

	g.Game()
}
