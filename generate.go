package main

import (
	"bufio"
	"denialanderror/multi-elastic/fakes"
	"encoding/json"
	"github.com/bxcodec/faker/v3"
	"os"
	"reflect"
)

func main() {
	generatePeople()
	generateFirms()
}

func generatePeople() {
	_ = faker.AddProvider("address", func(v reflect.Value) (interface{}, error) {
		address := fakes.Address{}
		_ = faker.FakeData(&address)
		return address, nil
	})

	f, _ := os.Create("persons.json")
	w := bufio.NewWriter(f)

	for i := 0; i < 100; i++ {
		person := fakes.Person{}
		_ = faker.FakeData(&person)
		j, _ := json.Marshal(person)
		_, _ = w.WriteString("{\"index\":{}}\n" + string(j) + "\n")
	}

	_ = w.Flush()
}

func generateFirms() {
	f, _ := os.Create("firms.json")
	w := bufio.NewWriter(f)

	for i := 0; i < 100; i++ {
		firm := fakes.Firm{}
		_ = faker.FakeData(&firm)
		j, _ := json.Marshal(firm)
		_, _ = w.WriteString("{\"index\":{}}\n" + string(j) + "\n")
	}

	_ = w.Flush()
}
