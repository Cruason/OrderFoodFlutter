package com.example.androidstrongapp.features.core.data.mapper

import com.example.androidstrongapp.features.core.data.dto.CapitalInfo
import com.example.androidstrongapp.features.core.data.dto.CountryDtoItem
import com.example.androidstrongapp.features.core.domain.entities.Country

fun CountryDtoItem.toCountry(): Country {
    return Country(
        name = name.common,
        flag = flags.png,
        capital = capital,
        capitalInfo = capitalInfo,
        population = population,
        area = area,
        currencies = currencies,
        region = region,
        timezones = timezones,
        continents = continents,
        cca2 = cca2
    )
}

fun CapitalInfo.toStringInfo(): List<String> {
    return latlng.map {
        "${it.toString().replace('.','°')}′"
    }
}
