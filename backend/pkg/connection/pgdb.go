package connection

import (
	"database/sql"
	"log"

	_ "github.com/lib/pq"
)

func GetDatabaseCursor() *sql.DB {
	connStr := "postgres://40a7f11db27c:82e176691e0d11a33ae98dc1da584da8@postgres-f40bc924-05d3-46e9-a9c7-6b5bc93abf21.cqryblsdrbcs.us-east-1.rds.amazonaws.com:7243/RMCqtmPeiQJY"
	db, err := sql.Open("postgres", connStr)
	if err != nil {
		log.Println("error while connecting")
		log.Println(err)
		return nil
	}
	return db
}
