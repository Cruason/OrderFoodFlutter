package com.example.androidstrongapp.features.core.presentation.pages.country_details_page

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
class CountryDetailsVIewModel @Inject constructor(
    private val countryRepository: CountryRepository
) : ViewModel() {
    private var _countryInfoState = mutableStateOf(CountryInfoState())
    val countryInfoState = _countryInfoState
    fun getCountry(ssa2: String) {
        viewModelScope.launch {
            countryRepository.getCountry(ssa2 = ssa2).collectLatest { result ->
                when (result) {
                    is Resource.Error -> {
                        _countryInfoState.value = _countryInfoState.value.copy(
                            loading = false,
                            message = result.message
                        )
                    }
                    is Resource.Loading -> {
                        _countryInfoState.value = _countryInfoState.value.copy(
                            loading = true
                        )
                    }
                    is Resource.Success -> {
                        val data = result.data
                        _countryInfoState.value = _countryInfoState.value.copy(
                            data = data,
                            loading = false
                        )
                    }
                }
            }
        }
    }
}