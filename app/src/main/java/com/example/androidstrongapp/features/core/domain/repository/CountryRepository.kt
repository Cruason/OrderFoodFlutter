package com.example.androidstrongapp.features.core.domain.repository

import com.example.androidstrongapp.features.core.domain.entities.Country
import com.example.androidstrongapp.features.core.util.Resource
import kotlinx.coroutines.flow.Flow

interface CountryRepository {
    suspend fun getAllCountry(): Flow<Resource<List<Country>>>

    suspend fun getCountry(ssa2: String): Flow<Resource<Country>>
}