package com.example.androidstrongapp.features.core.presentation.pages.country_list_page

import com.example.androidstrongapp.features.core.domain.entities.Country

data class CountryListState(
    val data: Map<List<String>?, List<Country>>? = null,
    val loading: Boolean = false,
    val message: String? = null
)