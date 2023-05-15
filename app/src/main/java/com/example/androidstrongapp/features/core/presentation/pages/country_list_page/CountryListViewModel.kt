package com.example.androidstrongapp.features.core.presentation.pages.country_list_page

import androidx.compose.runtime.mutableStateOf
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.example.androidstrongapp.features.core.domain.repository.CountryRepository
import com.example.androidstrongapp.features.core.util.Resource
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.flow.collectLatest
import kotlinx.coroutines.launch
import javax.inject.Inject


@HiltViewModel
class CountryListViewModel @Inject constructor(
    private val countryRepository: CountryRepository
):ViewModel() {
    private var _countryListState = mutableStateOf(CountryListState())
    val countryListState = _countryListState
    init {
        getAllCountry()
    }
    private fun getAllCountry(){
        viewModelScope.launch {
            countryRepository.getAllCountry().collectLatest {result->
                when(result){
                    is Resource.Error -> {
                        _countryListState.value = countryListState.value.copy(
                            loading = false,
                            message = result.message
                        )
                    }
                    is Resource.Loading -> {
                        _countryListState.value = countryListState.value.copy(
                            loading = true
                        )
                    }
                    is Resource.Success -> {
                        val data = result.data?.groupBy {
                            it.continents
                        }
                        _countryListState.value = countryListState.value.copy(
                            data = data,
                            loading = false
                        )
                    }
                }
            }
        }
    }
}