# value labels

qvars <- c('E1', 'E2', 'E3', 'E4', 'E5', 'E6', 'E7', 'E8', 'E9', 'E10',
           'N1', 'N2', 'N3', 'N4', 'N5', 'N6', 'N7', 'N8', 'N9', 'N10',
           'A1', 'A2', 'A3', 'A4', 'A5', 'A6', 'A7', 'A8', 'A9', 'A10',
           'C1', 'C2', 'C3', 'C4', 'C5', 'C6', 'C7', 'C8', 'C9', 'C10',
           'O1', 'O2', 'O3', 'O4', 'O5', 'O6', 'O7', 'O8', 'O9', 'O10')

for (i in qvars){
  attr(x[[i]], "labels") <- c("Strongly Disagree" = 1,
                              "Disagree" = 2,
                              "Neutral" = 3,
                              "Agree" = 4,
                              "Strongly Agree" = 5,
                              "missing" = 0)

  attr(x[[i]], "is_na") <- c(rep(FALSE, 5), TRUE)
}


# race
attr(x[["race"]], "labels") <- c("Mixed Race" = 1,
                                 "Arctic (Siberian, Eskimo)" = 2,
                                 "Caucasian (European)" = 3,
                                 "Caucasian (Indian)" = 4,
                                 "Caucasian (Middle East)" = 5,
                                 "Caucasian (North African, Other)" = 6,
                                 "Indigenous Australian" = 7,
                                 "Native American" = 8,
                                 "North East Asian (Mongol, Tibetan, Korean Japanese, etc)" = 9,
                                 "Pacific (Polynesian, Micronesian, etc)" = 10,
                                 "South East Asian (Chinese, Thai, Malay, Filipino, etc)" = 11,
                                 "West African, Bushmen, Ethiopian" = 12,
                                 "Other" = 13,
                                 "missing" = 0)
attr(x[["race"]], "is_na") <- c(rep(FALSE, 13), TRUE)

# engnat
attr(x[["engnat"]], "labels") <- c("Yes" = 1,
                                   "No" = 2,
                                   "missing" = 0)
attr(x[["engnat"]], "is_na") <- c(rep(FALSE, 2), TRUE)

# gender
attr(x[["gender"]], "labels") <- c("Male" = 1,
                                   "Female" = 2,
                                   "Other" = 3,
                                   "missing" = 0)
attr(x[["gender"]], "is_na") <- c(rep(FALSE, 3), TRUE)

# gender
attr(x[["hand"]], "labels") <- c("Right" = 1,
                                 "Left" = 2,
                                 "Both" = 3,
                                 "missing" = 0)
attr(x[["hand"]], "is_na") <- c(rep(FALSE, 3), TRUE)


# country
attr(x[["country"]], "labels") <- c("Anonymous Proxy" = "A1",
                                    "Satellite Provider" = "A2",
                                    "Other Country" = "O1",
                                    "Andorra" = "AD",
                                    "United Arab Emirates" = "AE",
                                    "Afghanistan" = "AF",
                                    "Antigua and Barbuda" = "AG",
                                    "Anguilla" = "AI",
                                    "Albania" = "AL",
                                    "Armenia" = "AM",
                                    "Angola" = "AO",
                                    "Asia/Pacific Region" = "AP",
                                    "Antarctica" = "AQ",
                                    "Argentina" = "AR",
                                    "American Samoa" = "AS",
                                    "Austria" = "AT",
                                    "Australia" = "AU",
                                    "Aruba" = "AW",
                                    "Aland Islands" = "AX",
                                    "Azerbaijan" = "AZ",
                                    "Bosnia and Herzegovina" = "BA",
                                    "Barbados" = "BB",
                                    "Bangladesh" = "BD",
                                    "Belgium" = "BE",
                                    "Burkina Faso" = "BF",
                                    "Bulgaria" = "BG",
                                    "Bahrain" = "BH",
                                    "Burundi" = "BI",
                                    "Benin" = "BJ",
                                    "Saint Bartelemey" = "BL",
                                    "Bermuda" = "BM",
                                    "Brunei Darussalam" = "BN",
                                    "Bolivia" = "BO",
                                    "Bonaire, Saint Eustatius and Saba" = "BQ",
                                    "Brazil" = "BR",
                                    "Bahamas" = "BS",
                                    "Bhutan" = "BT",
                                    "Bouvet Island" = "BV",
                                    "Botswana" = "BW",
                                    "Belarus" = "BY",
                                    "Belize" = "BZ",
                                    "Canada" = "CA",
                                    "Cocos (Keeling) Islands" = "CC",
                                    "Congo, The Democratic Republic of the" = "CD",
                                    "Central African Republic" = "CF",
                                    "Congo" = "CG",
                                    "Switzerland" = "CH",
                                    "Cote d'Ivoire" = "CI",
                                    "Cook Islands" = "CK",
                                    "Chile" = "CL",
                                    "Cameroon" = "CM",
                                    "China" = "CN",
                                    "Colombia" = "CO",
                                    "Costa Rica" = "CR",
                                    "Cuba" = "CU",
                                    "Cape Verde" = "CV",
                                    "Curacao" = "CW",
                                    "Christmas Island" = "CX",
                                    "Cyprus" = "CY",
                                    "Czech Republic" = "CZ",
                                    "Germany" = "DE",
                                    "Djibouti" = "DJ",
                                    "Denmark" = "DK",
                                    "Dominica" = "DM",
                                    "Dominican Republic" = "DO",
                                    "Algeria" = "DZ",
                                    "Ecuador" = "EC",
                                    "Estonia" = "EE",
                                    "Egypt" = "EG",
                                    "Western Sahara" = "EH",
                                    "Eritrea" = "ER",
                                    "Spain" = "ES",
                                    "Ethiopia" = "ET",
                                    "Europe" = "EU",
                                    "Finland" = "FI",
                                    "Fiji" = "FJ",
                                    "Falkland Islands (Malvinas)" = "FK",
                                    "Micronesia, Federated States of" = "FM",
                                    "Faroe Islands" = "FO",
                                    "France" = "FR",
                                    "Gabon" = "GA",
                                    "United Kingdom" = "GB",
                                    "Grenada" = "GD",
                                    "Georgia" = "GE",
                                    "French Guiana" = "GF",
                                    "Guernsey" = "GG",
                                    "Ghana" = "GH",
                                    "Gibraltar" = "GI",
                                    "Greenland" = "GL",
                                    "Gambia" = "GM",
                                    "Guinea" = "GN",
                                    "Guadeloupe" = "GP",
                                    "Equatorial Guinea" = "GQ",
                                    "Greece" = "GR",
                                    "South Georgia and the South Sandwich Islands" = "GS",
                                    "Guatemala" = "GT",
                                    "Guam" = "GU",
                                    "Guinea-Bissau" = "GW",
                                    "Guyana" = "GY",
                                    "Hong Kong" = "HK",
                                    "Heard Island and McDonald Islands" = "HM",
                                    "Honduras" = "HN",
                                    "Croatia" = "HR",
                                    "Haiti" = "HT",
                                    "Hungary" = "HU",
                                    "Indonesia" = "ID",
                                    "Ireland" = "IE",
                                    "Israel" = "IL",
                                    "Isle of Man" = "IM",
                                    "India" = "IN",
                                    "British Indian Ocean Territory" = "IO",
                                    "Iraq" = "IQ",
                                    "Iran, Islamic Republic of" = "IR",
                                    "Iceland" = "IS",
                                    "Italy" = "IT",
                                    "Jersey" = "JE",
                                    "Jamaica" = "JM",
                                    "Jordan" = "JO",
                                    "Japan" = "JP",
                                    "Kenya" = "KE",
                                    "Kyrgyzstan" = "KG",
                                    "Cambodia" = "KH",
                                    "Kiribati" = "KI",
                                    "Comoros" = "KM",
                                    "Saint Kitts and Nevis" = "KN",
                                    "Korea, Democratic People's Republic of" = "KP",
                                    "Korea, Republic of" = "KR",
                                    "Kuwait" = "KW",
                                    "Cayman Islands" = "KY",
                                    "Kazakhstan" = "KZ",
                                    "Lao People's Democratic Republic" = "LA",
                                    "Lebanon" = "LB",
                                    "Saint Lucia" = "LC",
                                    "Liechtenstein" = "LI",
                                    "Sri Lanka" = "LK",
                                    "Liberia" = "LR",
                                    "Lesotho" = "LS",
                                    "Lithuania" = "LT",
                                    "Luxembourg" = "LU",
                                    "Latvia" = "LV",
                                    "Libyan Arab Jamahiriya" = "LY",
                                    "Morocco" = "MA",
                                    "Monaco" = "MC",
                                    "Moldova, Republic of" = "MD",
                                    "Montenegro" = "ME",
                                    "Saint Martin" = "MF",
                                    "Madagascar" = "MG",
                                    "Marshall Islands" = "MH",
                                    "Macedonia" = "MK",
                                    "Mali" = "ML",
                                    "Myanmar" = "MM",
                                    "Mongolia" = "MN",
                                    "Macao" = "MO",
                                    "Northern Mariana Islands" = "MP",
                                    "Martinique" = "MQ",
                                    "Mauritania" = "MR",
                                    "Montserrat" = "MS",
                                    "Malta" = "MT",
                                    "Mauritius" = "MU",
                                    "Maldives" = "MV",
                                    "Malawi" = "MW",
                                    "Mexico" = "MX",
                                    "Malaysia" = "MY",
                                    "Mozambique" = "MZ",
                                    "Namibia" = "NA",
                                    "New Caledonia" = "NC",
                                    "Niger" = "NE",
                                    "Norfolk Island" = "NF",
                                    "Nigeria" = "NG",
                                    "Nicaragua" = "NI",
                                    "Netherlands" = "NL",
                                    "Norway" = "NO",
                                    "Nepal" = "NP",
                                    "Nauru" = "NR",
                                    "Niue" = "NU",
                                    "New Zealand" = "NZ",
                                    "Oman" = "OM",
                                    "Panama" = "PA",
                                    "Peru" = "PE",
                                    "French Polynesia" = "PF",
                                    "Papua New Guinea" = "PG",
                                    "Philippines" = "PH",
                                    "Pakistan" = "PK",
                                    "Poland" = "PL",
                                    "Saint Pierre and Miquelon" = "PM",
                                    "Pitcairn" = "PN",
                                    "Puerto Rico" = "PR",
                                    "Palestinian Territory" = "PS",
                                    "Portugal" = "PT",
                                    "Palau" = "PW",
                                    "Paraguay" = "PY",
                                    "Qatar" = "QA",
                                    "Reunion" = "RE",
                                    "Romania" = "RO",
                                    "Serbia" = "RS",
                                    "Russian Federation" = "RU",
                                    "Rwanda" = "RW",
                                    "Saudi Arabia" = "SA",
                                    "Solomon Islands" = "SB",
                                    "Seychelles" = "SC",
                                    "Sudan" = "SD",
                                    "Sweden" = "SE",
                                    "Singapore" = "SG",
                                    "Saint Helena" = "SH",
                                    "Slovenia" = "SI",
                                    "Svalbard and Jan Mayen" = "SJ",
                                    "Slovakia" = "SK",
                                    "Sierra Leone" = "SL",
                                    "San Marino" = "SM",
                                    "Senegal" = "SN",
                                    "Somalia" = "SO",
                                    "Suriname" = "SR",
                                    "South Sudan" = "SS",
                                    "Sao Tome and Principe" = "ST",
                                    "El Salvador" = "SV",
                                    "Sint Maarten" = "SX",
                                    "Syrian Arab Republic" = "SY",
                                    "Swaziland" = "SZ",
                                    "Turks and Caicos Islands" = "TC",
                                    "Chad" = "TD",
                                    "French Southern Territories" = "TF",
                                    "Togo" = "TG",
                                    "Thailand" = "TH",
                                    "Tajikistan" = "TJ",
                                    "Tokelau" = "TK",
                                    "Timor-Leste" = "TL",
                                    "Turkmenistan" = "TM",
                                    "Tunisia" = "TN",
                                    "Tonga" = "TO",
                                    "Turkey" = "TR",
                                    "Trinidad and Tobago" = "TT",
                                    "Tuvalu" = "TV",
                                    "Taiwan" = "TW",
                                    "Tanzania, United Republic of" = "TZ",
                                    "Ukraine" = "UA",
                                    "Uganda" = "UG",
                                    "United States Minor Outlying Islands" = "UM",
                                    "United States" = "US",
                                    "Uruguay" = "UY",
                                    "Uzbekistan" = "UZ",
                                    "Holy See (Vatican City State)" = "VA",
                                    "Saint Vincent and the Grenadines" = "VC",
                                    "Venezuela" = "VE",
                                    "Virgin Islands, British" = "VG",
                                    "Virgin Islands, U.S." = "VI",
                                    "Vietnam" = "VN",
                                    "Vanuatu" = "VU",
                                    "Wallis and Futuna" = "WF",
                                    "Samoa" = "WS",
                                    "Yemen" = "YE",
                                    "Mayotte" = "YT",
                                    "South Africa" = "ZA",
                                    "Zambia" = "ZM",
                                    "Zimbabwe" = "ZW")

#-------------------------------------------------------------------------------

# variable labels

attr(x[["race"]], "label")  <- "Race - Chosen from a drop down menu"
attr(x[["age"]], "label")   <- "Age - Entered as text"
attr(x[["engnat"]], "label")  <- "Response to 'is English your native language?'"
attr(x[["gender"]], "label")  <- "Gender - Chosen from a drop down menu"
attr(x[["hand"]], "label")  <- "What hand do you use to write with?"

attr(x[["E1"]], "label")  <- "I am the life of the party."
attr(x[["E2"]], "label")  <- "I don't talk a lot."
attr(x[["E3"]], "label")  <- "I feel comfortable around people."
attr(x[["E4"]], "label")  <- "I keep in the background."
attr(x[["E5"]], "label")  <- "I start conversations."
attr(x[["E6"]], "label")  <- "I have little to say."
attr(x[["E7"]], "label")  <- "I talk to a lot of different people at parties."
attr(x[["E8"]], "label")  <- "I don't like to draw attention to myself."
attr(x[["E9"]], "label")  <- "I don't mind being the center of attention."
attr(x[["E10"]], "label") <- "I am quiet around strangers."
attr(x[["N1"]], "label")  <- "I get stressed out easily."
attr(x[["N2"]], "label")  <- "I am relaxed most of the time."
attr(x[["N3"]], "label")  <- "I worry about things."
attr(x[["N4"]], "label")  <- "I seldom feel blue."
attr(x[["N5"]], "label")  <- "I am easily disturbed."
attr(x[["N6"]], "label")  <- "I get upset easily."
attr(x[["N7"]], "label")  <- "I change my mood a lot."
attr(x[["N8"]], "label")  <- "I have frequent mood swings."
attr(x[["N9"]], "label")  <- "I get irritated easily."
attr(x[["N10"]], "label") <- "I often feel blue."
attr(x[["A1"]], "label")  <- "I feel little concern for others."
attr(x[["A2"]], "label")  <- "I am interested in people."
attr(x[["A3"]], "label")  <- "I insult people."
attr(x[["A4"]], "label")  <- "I sympathize with others' feelings."
attr(x[["A5"]], "label")  <- "I am not interested in other people's problems."
attr(x[["A6"]], "label")  <- "I have a soft heart."
attr(x[["A7"]], "label")  <- "I am not really interested in others."
attr(x[["A8"]], "label")  <- "I take time out for others."
attr(x[["A9"]], "label")  <- "I feel others' emotions."
attr(x[["A10"]], "label") <- "I make people feel at ease."
attr(x[["C1"]], "label")  <- "I am always prepared."
attr(x[["C2"]], "label")  <- "I leave my belongings around."
attr(x[["C3"]], "label")  <- "I pay attention to details."
attr(x[["C4"]], "label")  <- "I make a mess of things."
attr(x[["C5"]], "label")  <- "I get chores done right away."
attr(x[["C6"]], "label")  <- "I often forget to put things back in their proper place."
attr(x[["C7"]], "label")  <- "I like order."
attr(x[["C8"]], "label")  <- "I shirk my duties."
attr(x[["C9"]], "label")  <- "I follow a schedule."
attr(x[["C10"]], "label") <- "I am exacting in my work."
attr(x[["O1"]], "label")  <- "I have a rich vocabulary."
attr(x[["O2"]], "label")  <- "I have difficulty understanding abstract ideas."
attr(x[["O3"]], "label")  <- "I have a vivid imagination."
attr(x[["O4"]], "label")  <- "I am not interested in abstract ideas."
attr(x[["O5"]], "label")  <- "I have excellent ideas."
attr(x[["O6"]], "label")  <- "I do not have a good imagination."
attr(x[["O7"]], "label")  <- "I am quick to understand things."
attr(x[["O8"]], "label")  <- "I use difficult words."
attr(x[["O9"]], "label")  <- "I spend time reflecting on things."
attr(x[["O10"]], "label") <- "I am full of ideas."

#-------------------------------------------------------------------------------
#----------------------------------------------------------------------------end
#-------------------------------------------------------------------------------
