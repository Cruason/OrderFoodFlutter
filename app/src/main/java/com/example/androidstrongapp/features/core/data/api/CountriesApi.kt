package com.example.androidstrongapp.features.core.data.api

import com.example.androidstrongapp.features.core.data.dto.CountryDto
import com.example.androidstrongapp.features.core.data.dto.CountryDtoItem
import retrofit2.http.GET
import retrofit2.http.Path

interface CountriesApi {
    @GET("/v3.1/all")
    suspend fun getAllCountry(): CountryDto

    @GET("/v3.1/alpha/{ssa2_code}")
    suspend fun getCountry(
        @Path("ssa2_code") ssa2: String
    ): CountryDto

    companion object {
        const val BASE_URL = "https://restcountries.com/"
    }
}