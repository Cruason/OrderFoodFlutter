package com.example.androidstrongapp.features.core.presentation.pages.country_details_page

import com.example.androidstrongapp.features.core.domain.entities.Country

data class CountryInfoState(
    val data: Country? = null,
    val message: String? = null,
    val loading: Boolean = false
)