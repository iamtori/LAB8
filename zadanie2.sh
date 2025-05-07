#!/bin/bash

# Wprowadzamy temat wyszukiwania
read -p "Podaj temat wyszukiwania: " topic

# Klucz dla API
api_key="397eeda2ccb4491e901716745818fe97"

# Zapytanie  API
response=$(curl -s "https://newsapi.org/v2/everything -G \  -d $apiKey)

# Przetwarzanie wyników
echo "Wyniki wyszukiwania dla tematu '$topic':"
echo "$response" | jq '.value[] | {name, url}'
