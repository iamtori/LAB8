$apiKey = "e8875ee7d1d1c18a8b06c374"
$currency = "USD" 
$baseCurrency = "PLN"  

# Pobieranie aktualnego kursu
$currentDate = (Get-Date).ToString("yyyy-MM-dd")
$currentRateUrl = "https://v6.exchangerate-api.com/v6/$apiKey/latest/$baseCurrency"
$currentRate = Invoke-RestMethod -Uri $currentRateUrl
$currentRateValue = $currentRate.conversion_rates.$currency

# Pobieranie kursów z ostatnich 5 dni
$ratesUrl = "https://v6.exchangerate-api.com/v6/$apiKey/history/$baseCurrency?start_date=$(($currentDate - (New-TimeSpan -Days 5)).ToString("yyyy-MM-dd"))&end_date=$currentDate"
$historyRates = Invoke-RestMethod -Uri $ratesUrl

# Obliczanie różnicy kursów
$previousRates = $historyRates.conversion_rates.PSObject.Properties.Name | Select-Object -Skip 1 
$previousRates = $previousRates | ForEach-Object {
    $date = $_
    $rate = $historyRates.conversion_rates.$date.$currency
    $difference = [math]::Round($rate - $currentRateValue, 4)
    [PSCustomObject]@{Date = $date; Rate = $rate; Difference = $difference}
}

# Wyświetlanie wyników
$currentRateValue
$previousRates | Format-Table



