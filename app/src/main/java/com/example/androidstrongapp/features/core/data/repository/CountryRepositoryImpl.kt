package com.example.androidstrongapp.features.core.data.repository

import android.util.Log
import com.example.androidstrongapp.features.core.data.api.CountriesApi
import com.example.androidstrongapp.features.core.data.mapper.toCountry
import com.example.androidstrongapp.features.core.domain.entities.Country
import com.example.androidstrongapp.features.core.domain.repository.CountryRepository
import com.example.androidstrongapp.features.core.util.Resource
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.flow
import retrofit2.HttpException
import java.io.IOException
import javax.inject.Inject
import javax.inject.Singleton

@Singleton
class CountryRepositoryImpl @Inject constructor(
    private val countryApi: CountriesApi
) : CountryRepository{
    override suspend fun getAllCountry(): Flow<Resource<List<Country>>> {
        return flow {
            emit(Resource.Loading())
            try {
                val data = countryApi.getAllCountry().map {
                    it.toCountry()
                }
                emit(Resource.Success(data = data))
            } catch (e: IOException){
                emit(Resource.Error(message = e.message))
            } catch (e: HttpException){
                emit(Resource.Error(message = e.message))
            }
        }
    }

    override suspend fun getCountry(ssa2: String): Flow<Resource<Country>> {
        return flow {
            emit(Resource.Loading())
            try {
                val data = countryApi.getCountry(ssa2 = ssa2).map {
                    it.toCountry()
                }
                Log.d("CHECKTHAT", data[0].currencies.toString())
                emit(Resource.Success(data = data[0]))
            } catch (e: IOException){
                emit(Resource.Error(message = e.message))
            } catch (e: HttpException){
                emit(Resource.Error(message = e.message))
            }
        }
    }
}