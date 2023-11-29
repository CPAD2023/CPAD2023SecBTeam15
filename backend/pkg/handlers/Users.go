package handlers

import (
	"database/sql"
	"encoding/json"
	"log"
	"main/pkg/connection"
	"main/pkg/models"
	"net/http"
)

func GetUsers(w http.ResponseWriter, r *http.Request) {

	//list of users
	var users []models.User

	db := connection.GetDatabaseCursor()
	err := db.Ping()
	if err != nil {
		log.Println(err)
	}
	log.Println(db)
	rows, err := db.Query("SELECT * FROM USERS")
	if err != nil {
		return
	}
	// Iterate over the result set
	for rows.Next() {
		var email_id string
		var pass string

		err := rows.Scan(&email_id, &pass)
		if err != nil {
			log.Fatal(err)
		}

		user := models.User{
			EmailId:  email_id,
			Password: pass,
		}

		users = append(users, user)
	}
	err = json.NewEncoder(w).Encode(users)
	if err != nil {
		return
	}
	// Check for errors from iterating over rows
	if err = rows.Err(); err != nil {
		log.Fatal(err)
	}

	defer func(db *sql.DB) {
		log.Println("Closing DB")
		err := db.Close()
		if err != nil {
			log.Println("error while closing")
		}
	}(db)
}

func ValidateUser(w http.ResponseWriter, r *http.Request) {
	params := r.URL.Query()
	emailId := params.Get("emailId")
	password := params.Get("password")

	validateUser := models.User{
		EmailId:  emailId,
		Password: password,
	}
	var validateFlag bool
	//getting database cursor
	db := connection.GetDatabaseCursor()
	rows, err := db.Query("SELECT * FROM USERS WHERE email_id = $1 AND pass = $2", emailId, password)
	if err != nil {
		return
	}
	// Iterate over the result set
	for rows.Next() {
		var email_id string
		var pass string

		err := rows.Scan(&email_id, &pass)
		if err != nil {
			log.Fatal(err)
		}

		tempUser := models.User{
			EmailId:  email_id,
			Password: pass,
		}

		if tempUser == validateUser {
			validateFlag = true
		}
	}
	if validateFlag {
		err := json.NewEncoder(w).Encode("Validated")
		if err != nil {
			return
		}
	} else {
		w.WriteHeader(403)
	}
	// Check for errors from iterating over rows
	if err = rows.Err(); err != nil {
		log.Fatal(err)
	}

	defer func(db *sql.DB) {
		log.Println("Closing DB")
		err := db.Close()
		if err != nil {
			log.Println("error while closing")
		}
	}(db)
}

func AddUserHandler(w http.ResponseWriter, r *http.Request) {
	var newUser models.User
	json.NewDecoder(r.Body).Decode(&newUser)

	//get db cursor
	db := connection.GetDatabaseCursor()
	result, err := db.Exec("INSERT INTO USERS VALUES($1,$2)", newUser.EmailId, newUser.Password)
	if err != nil {
		log.Fatal(err)
	}
	rowsAffected, err := result.RowsAffected()
	if err != nil {
		log.Fatal(err)
	}
	if rowsAffected >= 1 {
		w.Write([]byte("Record Added"))
	} else {
		w.WriteHeader(401)
	}
}
