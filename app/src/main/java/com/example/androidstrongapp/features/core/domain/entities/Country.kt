package com.example.androidstrongapp.features.core.domain.entities

import com.example.androidstrongapp.features.core.data.dto.CapitalInfo
import com.example.androidstrongapp.features.core.data.dto.Currencies

data class Country(
    val name: String?,
    val flag: String?,
    val capital: List<String>?,
    val capitalInfo: CapitalInfo?,
    val population: Int?,
    val area: Double?,
    val currencies: Currencies?,
    val region: String?,
    val timezones: List<String>?,
    val continents: List<String>?,
    val cca2: String?,
    )
