package com.example.androidstrongapp.features.core.di

import com.example.androidstrongapp.features.core.data.api.CountriesApi
import dagger.Module
import dagger.Provides
import dagger.hilt.InstallIn
import dagger.hilt.components.SingletonComponent
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory
import retrofit2.create
import javax.inject.Singleton

@Module
@InstallIn(SingletonComponent::class)
object RemoteModule {
    @Singleton
    @Provides
    fun provideCountriesApi(): CountriesApi {
        return Retrofit.Builder().baseUrl(CountriesApi.BASE_URL)
            .addConverterFactory(GsonConverterFactory.create()).build().create()
    }
}