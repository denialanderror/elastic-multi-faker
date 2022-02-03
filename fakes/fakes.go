package fakes

type Person struct {
	ID            int64   `json:"id"`
	UID           string  `faker:"uuid_hyphenated" json:"uId"`
	CaseRecNumber string  `faker:"uuid_digit" json:"caseRecNumber"`
	PersonType    string  `faker:"oneof: CLIENT, DEPUTY, DONOR" json:"personType"`
	Dob           string  `faker:"date" json:"dob"`
	Email         string  `faker:"email" json:"email"`
	Firstname     string  `faker:"first_name" json:"firstname"`
	Surname       string  `faker:"last_name" json:"surname"`
	CompanyName   string  `json:"companyName"`
	Addresses     Address `faker:"address" json:"addresses"`
}

type Address struct {
	AddressLines []string `faker:"slice_len=2" json:"addressLines"`
	Postcode     string   `faker:"word" json:"postcode"`
}

type Firm struct {
	ID           int64  `json:"id"`
	UID          string `faker:"uuid_hyphenated" json:"uId"`
	Email        string `faker:"email" json:"email"`
	CompanyName  string `faker:"word" json:"firmName"`
	FirmNumber   string `faker:"word" json:"firmNumber"`
	AddressLine1 string `faker:"word" json:"addressLine1"`
	AddressLine2 string `faker:"word" json:"addressLine2"`
	AddressLine3 string `faker:"word" json:"addressLine3"`
	Town         string `faker:"word" json:"town"`
	Country      string `faker:"word" json:"country"`
	Postcode     string `faker:"word" json:"postcode"`
	PhoneNumber  string `faker:"phone_number" json:"phoneNumber"`
}
