package com.example.androidstrongapp.features.core.presentation.pages.country_list_page

import androidx.compose.foundation.Image
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.rememberLazyListState
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.layout.ContentScale
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.text.SpanStyle
import androidx.compose.ui.text.buildAnnotatedString
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.withStyle
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import com.bumptech.glide.integration.compose.ExperimentalGlideComposeApi
import com.bumptech.glide.integration.compose.GlideImage
import com.example.androidstrongapp.R
import com.example.androidstrongapp.features.theme.*
import kotlin.math.roundToInt

@Composable
fun CountryListPage(
    countryListViewModel: CountryListViewModel,
    onMoreClick: (String) -> Unit
) {
    val scrollState= rememberLazyListState()
    val countryListState = countryListViewModel.countryListState.value
    Column(
        modifier = Modifier
            .fillMaxSize()
    ) {
        TextHeader()
        Divider(
            modifier = Modifier
                .fillMaxWidth()
                .padding(vertical = 10.dp),
            color = DividerColor.copy(alpha = 0.35f),
            thickness = 1.dp,
            startIndent = 0.dp
        )
        Spacer(modifier = Modifier.height(12.dp))
        if (countryListState.loading) {
            Box(contentAlignment = Alignment.Center, modifier = Modifier.fillMaxSize()) {
                CircularProgressIndicator(color = Color.Black)
            }
        } else if (!countryListState.message.isNullOrEmpty()) {
            Box(contentAlignment = Alignment.Center, modifier = Modifier.fillMaxSize()) {
                Text(text = countryListState.message, color = Color.Red, fontSize = 24.sp)
            }
        } else {
            LazyColumn(state = scrollState) {
                item {
                    countryListState.data?.keys?.forEach { continent ->
                        Text(
                            buildAnnotatedString {
                                continent?.forEach {
                                    append(it)
                                    if ((continent.size > 1) && (it.lastIndex != (continent.size - 1))) {
                                        append(", ")
                                    }
                                }
                            },
                            fontFamily = RobotoFamily,
                            fontWeight = FontWeight(700),
                            fontSize = 15.sp,
                            lineHeight = 17.58.sp,
                            color = GrayABB3BB,
                            letterSpacing = 1.6.sp,
                            modifier = Modifier
                                .fillMaxWidth()
                                .padding(vertical = 12.dp)
                        )
                        countryListState.data[continent]?.forEach {
                            CountryItem(
                                name = it.name ?: "",
                                flag = it.flag ?: "",
                                capital = it.capital ?: arrayListOf(),
                                population = it.population ?: 0,
                                area = it.area ?: 0.0,
                                currencyName =  "",
                                currencySymbol = "",
                            ) {
                                onMoreClick(it.cca2 ?: "")

                            }
                            Spacer(modifier = Modifier.height(12.dp))
                        }
                    }
                }
            }
        }

    }
}

@Composable
private fun TextHeader() {
    Text(
        text = "World countries",
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

@OptIn(ExperimentalGlideComposeApi::class)
@Composable
fun CountryItem(
    name: String,
    flag: String,
    capital: List<String>,
    population: Int,
    area: Double,
    currencyName: String,
    currencySymbol: String,
    onMoreClick: () -> Unit
) {
    var collapsed by remember {
        mutableStateOf(true)
    }
    Column(
        modifier = Modifier
            .fillMaxWidth()
            .padding(vertical = 12.dp, horizontal = 12.dp)
    ) {
        Row(
            verticalAlignment = Alignment.CenterVertically,
            modifier = Modifier.fillMaxWidth(),
            horizontalArrangement = Arrangement.SpaceBetween
        ) {
            Row(verticalAlignment = Alignment.CenterVertically) {
                GlideImage(
                    model = flag,
                    contentDescription = name,
                    modifier = Modifier
                        .width(82.dp)
                        .height(48.dp)
                        .clip(
                            RoundedCornerShape(8.dp)
                        ),
                    contentScale = ContentScale.Crop
                )
                Spacer(modifier = Modifier.width(12.dp))
                Column {
                    Text(
                        text = name,
                        fontFamily = RobotoFamily,
                        fontWeight = FontWeight(600),
                        fontSize = 17.sp,
                        lineHeight = 19.sp,
                        color = Color.Black
                    )
                    Spacer(modifier = Modifier.height(4.dp))
                    Text(
                        buildAnnotatedString {
                            capital.forEach {
                                append(it)
                                if (capital.size > 1 && it.lastIndex != capital.size - 1) {
                                    append(", ")
                                }
                            }
                        },
                        fontFamily = RobotoFamily,
                        fontWeight = FontWeight(600),
                        fontSize = 14.sp,
                        lineHeight = 16.41.sp,
                        color = Gray888888
                    )
                }
            }

            Image(
                painter = painterResource(
                    id = if (collapsed) {
                        R.drawable.arrow_down
                    } else {
                        R.drawable.arrow_up
                    }
                ), contentDescription = "collapse/expand",
                modifier = Modifier
                    .size(24.dp)
                    .clickable {
                        collapsed = !collapsed
                    }
            )
        }
        if (!collapsed) {
            Spacer(modifier = Modifier.height(12.dp))
            Expanded(
                population = population,
                area = area,
                currencyName = currencyName,
                currencySymbol = currencySymbol
            ) {
                onMoreClick()
            }
        }
    }
}

@Composable
private fun Expanded(
    population: Int,
    area: Double,
    currencyName: String,
    currencySymbol: String,
    onMoreClick: () -> Unit
) {
    Column {
        Text(
            buildAnnotatedString {
                withStyle(style = SpanStyle(color = Gray888888)) {
                    append("Population: ")
                }
                withStyle(style = SpanStyle(color = Color.Black)) {
                    append(if (population.div(1000000)!! >= 1) {
                        population.div(1000000).toString() + " mln"
                    } else {
                        population.toString()
                    })
                }
            },
            fontFamily = RobotoFamily,
            fontWeight = FontWeight(400),
            fontSize = 15.sp,
            lineHeight = 17.58.sp,
        )
        Spacer(modifier = Modifier.height(8.dp))
        Text(
            buildAnnotatedString {
                withStyle(style = SpanStyle(color = Gray888888)) {
                    append("Area: ")
                }
                withStyle(style = SpanStyle(color = Color.Black)) {
                    append(if ( area.div(1000000)!! >= 1) {
                        area.div(1000000).toString() + " mln" + " km²"
                    } else {
                        "$area km²"
                    })
                }
            },
            fontFamily = RobotoFamily,
            fontWeight = FontWeight(400),
            fontSize = 15.sp,
            lineHeight = 17.58.sp
        )
        Spacer(modifier = Modifier.height(8.dp))
        Text(
            buildAnnotatedString {
                withStyle(style = SpanStyle(color = Gray888888)) {
                    append("Currency: ")
                }
                withStyle(style = SpanStyle(color = Color.Black)) {
                    append("$currencyName, $currencySymbol")
                }
            },
            fontFamily = RobotoFamily,
            fontWeight = FontWeight(400),
            fontSize = 15.sp,
            lineHeight = 17.58.sp,
        )
        Button(
            elevation = ButtonDefaults.elevation(
                0.dp
            ),
            colors= ButtonDefaults.buttonColors(
                backgroundColor = Color.Transparent,
                contentColor = Purple6200EE
            ),
            modifier = Modifier
                .fillMaxWidth()
                .padding(vertical = 10.dp), onClick = {
            onMoreClick()
        }) {
            Text(
                text = "LEARN MORE",
                fontFamily = RobotoFamily,
                fontWeight = FontWeight(500),
                fontSize = 14.sp,
                lineHeight = 16.sp,
                letterSpacing = 1.25.sp,
            )
        }
    }
}