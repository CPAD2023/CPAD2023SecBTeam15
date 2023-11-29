package routers

import (
	"github.com/gorilla/mux"
	"main/pkg/handlers"
)

func CreateMuxRouter() *mux.Router {
	router := mux.NewRouter()
	router.HandleFunc("/getUsers", handlers.GetUsers).Methods("GET")
	router.HandleFunc("/validateUser", handlers.ValidateUser).Methods("GET")
	router.HandleFunc("/addUser", handlers.AddUserHandler).Methods("POST")
	return router
}
