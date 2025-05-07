import requests

# Wprowadź swój klucz API Shodan
api_key = 'nTth2VFiMN4AnGD86iRLjTCPSEtPGjrr'

# Wprowadź adres IP, którego dane chcesz uzyskać
ip_address = input("Podaj adres IP: ")

# URL do API Shodan
url = f"https://api.shodan.io/shodan/host/{ip_address}?key={api_key}"

# Wysyłanie zapytania do API
response = requests.get(url)
data = response.json()

# Wyświetlanie podstawowych informacji i otwartych portów
print(f"Informacje o adresie IP {ip_address}:")
print(f"Organizacja: {data.get('org', 'Brak danych')}")
print(f"Lokalizacja: {data.get('location', {}).get('country_name', 'Brak danych')}")

print("\nOtwarte porty:")
for port in data.get('ports', []):
    print(f"Port: {port}")
