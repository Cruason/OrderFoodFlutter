package com.example.androidstrongapp.features.core.presentation.nav

import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.padding
import androidx.compose.material.Scaffold
import androidx.compose.material.rememberScaffoldState
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp
import androidx.hilt.navigation.compose.hiltViewModel
import androidx.navigation.compose.NavHost
import androidx.navigation.compose.composable
import androidx.navigation.compose.rememberNavController
import com.example.androidstrongapp.features.core.presentation.pages.country_details_page.CountryDetailsPage
import com.example.androidstrongapp.features.core.presentation.pages.country_details_page.CountryDetailsVIewModel
import com.example.androidstrongapp.features.core.presentation.pages.country_list_page.CountryListPage
import com.example.androidstrongapp.features.core.presentation.pages.country_list_page.CountryListViewModel
import com.example.androidstrongapp.features.core.util.Page

@Composable
fun CustomNavigation() {
    val navController = rememberNavController()
    val scaffoldState = rememberScaffoldState()
    val countryListViewModel: CountryListViewModel = hiltViewModel()
    val countryDetailsVIewModel: CountryDetailsVIewModel = hiltViewModel()

    Scaffold(
        modifier = Modifier
            .fillMaxSize()
            .padding(horizontal = 16.dp),
        scaffoldState = scaffoldState,
    ){padding->
        NavHost(navController = navController, startDestination = Page.CountryListPage.route, modifier = Modifier.padding(padding)){
            composable(route = Page.CountryListPage.route){
                CountryListPage(
                    countryListViewModel = countryListViewModel
                ){
                    countryDetailsVIewModel.getCountry(it)
                    navController.navigate(Page.CountryDetailsPage.route)
                }
            }
            composable(route = Page.CountryDetailsPage.route){
                CountryDetailsPage(countryDetailsVIewModel = countryDetailsVIewModel) {
                    navController.navigate(Page.CountryListPage.route)
                }
            }
        }
    }
}