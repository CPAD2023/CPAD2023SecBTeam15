package models

type User struct {
	EmailId  string `json:"email_id,omitempty"`
	Password string `json:"password,omitempty"`
}
