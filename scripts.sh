# use the log files provided or generate your own with `generate.go`

# creates the persons index with appropriate weighting and collated search properties
curl -X PUT "localhost:9200/persons?pretty" -H 'Content-Type: application/json' -d'
{
  "mappings": {
    "properties": {
      "searchable": {
        "type": "text"
      },
      "uId": {
        "type": "keyword",
        "copy_to": "searchable"
      },
      "caseRecNumber": {
        "type": "text",
        "copy_to": "searchable"
      },
      "personType": {
        "type": "keyword",
        "copy_to": "searchable"
      },
      "dob": {
        "type": "text",
        "copy_to": "searchable",
        "boost": 4.0
      },
      "email": {
        "type": "text",
        "boost": 4.0
      },
      "firstname": {
        "type": "text",
        "copy_to": "searchable",
        "boost": 4.0
      },
      "surname": {
        "type": "keyword",
        "copy_to": "searchable",
        "boost": 4.0
      },
      "companyName": {
        "type": "text",
        "copy_to": "searchable",
        "boost": 4.0
      },
      "phoneNumbers": {
        "properties": {
          "phoneNumber": {
            "type": "keyword",
            "copy_to": "searchable"
          }
        }
      },
      "addresses": {
        "properties": {
          "addressLines": {
            "type": "text",
            "copy_to": "searchable",
            "boost": 4.0
          },
          "postcode": {
            "type": "keyword",
            "copy_to": "searchable"
          }
        }
      }
    }
  }
}
'

# ingests person data
curl -H 'Content-Type: application/x-ndjson' -XPOST 'localhost:9200/persons/_bulk?pretty' --data-binary @persons.json

# creates the firms index with appropriate weighting and collated search properties
curl -X PUT "localhost:9200/firms?pretty" -H 'Content-Type: application/json' -d'
{
  "mappings": {
    "properties": {
      "searchable": {
        "type": "text"
      },
      "uId": {
        "type": "keyword",
        "copy_to": "searchable"
      },
      "email": {
        "type": "text",
        "boost": 4.0
      },
      "firmName": {
        "type": "text",
        "copy_to": "searchable",
        "boost": 4.0
      },
      "firmNumber": {
        "type": "text",
        "copy_to": "searchable",
        "boost": 4.0
      },
      "addressLine1": {
        "type": "text",
        "copy_to": "searchable",
        "boost": 4.0
      },
      "addressLine2": {
        "type": "text",
        "copy_to": "searchable",
        "boost": 4.0
      },
      "addressLine3": {
        "type": "text",
        "copy_to": "searchable",
        "boost": 4.0
      },
      "postcode": {
        "type": "text",
        "copy_to": "searchable"
      },
      "phoneNumber": {
        "type": "text",
        "copy_to": "searchable"
      }
    }
  }
}
'

# ingests firms data
curl -H 'Content-Type: application/x-ndjson' -XPOST 'localhost:9200/firms/_bulk?pretty' --data-binary @firms.json

# sample query to prove multi-index search - returns `sample.json` with default dataset
curl -XGET "http://es01:9200/persons,firms/_search" -H 'Content-Type: application/json' -d'
{
  "query": {
    "bool": {
      "must": {
        "simple_query_string": {
          "query": "dolorem",
          "fields": ["searchable", "caseRecNumber"],
          "default_operator": "AND"
        }
      }
    }
  },
  "aggs": {
    "personType": {
      "terms": {
        "field": "personType"
      }
    }
  }
}'
