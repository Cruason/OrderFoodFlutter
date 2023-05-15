package com.example.androidstrongapp.features.core.util

sealed class Page(val route: String){
    object CountryListPage:Page(route = "country_list_page")
    object CountryDetailsPage:Page(route = "country_details_page")
}
