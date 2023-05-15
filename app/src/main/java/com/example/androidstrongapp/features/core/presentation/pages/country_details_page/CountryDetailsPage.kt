package com.example.androidstrongapp.features.core.presentation.pages.country_details_page

import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.foundation.verticalScroll
import androidx.compose.material.CircularProgressIndicator
import androidx.compose.material.Icon
import androidx.compose.material.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.layout.ContentScale
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.text.buildAnnotatedString
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import com.bumptech.glide.integration.compose.ExperimentalGlideComposeApi
import com.bumptech.glide.integration.compose.GlideImage
import com.example.androidstrongapp.features.theme.RobotoFamily
import com.example.androidstrongapp.R
import com.example.androidstrongapp.features.core.data.mapper.toStringInfo
import com.example.androidstrongapp.features.theme.Gray888888

@OptIn(ExperimentalGlideComposeApi::class)
@Composable
fun CountryDetailsPage(
    countryDetailsVIewModel: CountryDetailsVIewModel,
    backPressed: () -> Unit
) {
    val scrollState = rememberScrollState()
    val countryInfoState = countryDetailsVIewModel.countryInfoState.value
    Column(
        modifier = Modifier
            .fillMaxSize()
            .verticalScroll(state = scrollState)
            .padding(horizontal = 16.dp)
    ) {
        if (countryInfoState.loading) {
            Box(contentAlignment = Alignment.Center, modifier = Modifier.fillMaxSize()) {
                CircularProgressIndicator(color = Color.Black)
            }
        } else if (!countryInfoState.message.isNullOrEmpty()) {
            Box(contentAlignment = Alignment.Center, modifier = Modifier.fillMaxSize()) {
                Text(text = countryInfoState.message, color = Color.Red, fontSize = 24.sp)
            }
        } else {
            TopHeader(countryInfoState.data?.name ?: "") {
                backPressed()
            }
            GlideImage(
                model = countryInfoState.data?.flag,
                contentDescription = countryInfoState.data?.name ?: "",
                modifier = Modifier
                    .width(330.dp)
                    .height(190.dp)
                    .clip(RoundedCornerShape(8.dp)),
                contentScale = ContentScale.Crop
            )
            Spacer(modifier = Modifier.height(24.dp))
            InfoField(
                title = "Capital",
                value = countryInfoState.data?.capital ?: arrayListOf(),
                divider = ", "
            )
            Spacer(modifier = Modifier.height(24.dp))
            InfoField(
                title = "Capital coordinates:",
                value = countryInfoState.data?.capitalInfo?.toStringInfo() ?: arrayListOf(),
                divider = ", "
            )
            Spacer(modifier = Modifier.height(24.dp))
            InfoField(
                title = "Population:",
                value = if (countryInfoState.data?.population?.div(1000000)!! >= 1) {
                    countryInfoState.data.population.div(1000000).toString() + " mln"
                } else {
                    countryInfoState.data.population.toString()
                }
            )
            Spacer(modifier = Modifier.height(24.dp))
            InfoField(
                title = "Area:",
                value = if ( countryInfoState.data.area?.div(1000000)!! >= 1) {
                    countryInfoState.data.area.div(1000000).toString() + " mln" + " km²"
                } else {
                    countryInfoState.data.area.toString() + " km²"
                }
            )
            Spacer(modifier = Modifier.height(24.dp))
            InfoField(
                title = "Currency:",
                value = arrayListOf(),
                divider = "\n"
            )
            Spacer(modifier = Modifier.height(24.dp))
            InfoField(
                title = "Region:",
                value = countryInfoState.data?.region ?: "",
            )
            Spacer(modifier = Modifier.height(24.dp))
            InfoField(
                title = "Timezones:",
                value = countryInfoState.data?.timezones ?: arrayListOf(),
                divider = "\n"
            )
            Spacer(modifier = Modifier.height(24.dp))
        }
    }
}

@Composable
private fun TopHeader(
    title: String,
    backPressed: () -> Unit
) {
    Row(verticalAlignment = Alignment.CenterVertically) {
        Icon(
            painter = painterResource(id = R.drawable.arrow_back),
            contentDescription = "back",
            modifier = Modifier
                .size(24.dp)
                .clickable {
                    backPressed()
                },
            tint = Color.Black
        )
        Spacer(modifier = Modifier.width(30.dp))
        Text(
            text = title,
            modifier = Modifier
                .fillMaxWidth()
                .padding(vertical = 16.dp),
            fontFamily = RobotoFamily,
            fontWeight = FontWeight(500),
            fontSize = 20.sp,
            lineHeight = 24.sp,
            letterSpacing = 0.15.sp,
            color = Color.Black
        )
    }

}

@Composable
private fun InfoField(
    title: String,
    value: List<String>,
    divider: String
) {
    Row {
        Icon(
            painter = painterResource(id = R.drawable.bullet_icon),
            contentDescription = "bullet",
            modifier = Modifier.size(24.dp),
            tint = Color.Black
        )
        Spacer(modifier = Modifier.width(8.dp))
        Column {
            Text(
                text = title,
                fontFamily = RobotoFamily,
                fontWeight = FontWeight(400),
                fontSize = 15.sp,
                lineHeight = 17.58.sp,
                color = Gray888888
            )
            Spacer(modifier = Modifier.height(4.dp))
            Text(
                buildAnnotatedString {
                    value.forEach {
                        append("$it ")
                        if (value.size > 1 && it.lastIndex != value.size - 1) {
                            append(divider)
                        }
                    }
                },
                fontFamily = RobotoFamily,
                fontWeight = FontWeight(400),
                fontSize = 20.sp,
                lineHeight = 24.sp,
                color = Color.Black
            )
        }
    }
}

@Composable
private fun InfoField(
    title: String,
    value: String,
) {
    Row {
        Icon(
            painter = painterResource(id = R.drawable.bullet_icon),
            contentDescription = "bullet",
            modifier = Modifier.size(24.dp),
            tint = Color.Black
        )
        Spacer(modifier = Modifier.width(8.dp))
        Column {
            Text(
                text = title,
                fontFamily = RobotoFamily,
                fontWeight = FontWeight(400),
                fontSize = 15.sp,
                lineHeight = 17.58.sp,
                color = Gray888888
            )
            Spacer(modifier = Modifier.height(4.dp))
            Text(
                text = value,
                fontFamily = RobotoFamily,
                fontWeight = FontWeight(400),
                fontSize = 20.sp,
                lineHeight = 24.sp,
                color = Color.Black
            )
        }
    }
}