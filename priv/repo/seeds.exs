# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Mach10.Repo.insert!(%Mach10.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

users = [
  "Jose Lawson",
  "Milagros Andrade",
  "Antone Cross",
  "Melvin Paul",
  "Refugio Downs",
  "Clare Hanna",
  "Roberta Davis",
  "Charity Mendoza",
  "Tad Hartman",
  "Helga Myers",
  "Bonita Mcclain",
  "Enrique Roman",
  "Rodrigo Franco",
  "Ned Villarreal",
  "Marci Valentine",
  "Twila Kirby",
  "Casey Curtis",
  "Houston Casey",
  "Alba Rivera",
  "Terrence Escobar",
  "Luz Morton",
  "Luther Yates",
  "Darin Maynard",
  "Therese Avila",
  "Alfreda Lawrence",
  "Johanna Steele",
  "Penny Kaiser",
  "Lynwood Collier",
  "Santo Clarke",
  "Cheri Cohen",
  "Osvaldo Jennings",
  "Sheldon Dean",
  "Alex Moreno",
  "Brendon Cardenas",
  "Dante Bradley",
  "Emmett Sims",
  "Daren Robertson",
  "Berry Mcmahon",
  "Robert Carlson",
  "Lori Daugherty",
  "Kerry Young",
  "Nicky Key",
  "Frieda Porter",
  "Chadwick Pacheco",
  "Jay Roach",
  "Noe Clements",
  "Tyron Coleman",
  "Raphael Stuart",
  "Grant Griffin",
  "Carlene Wong",
  "Sophie Vaughan",
  "Shelia Hudson",
  "Darnell Mcknight",
  "Earle Phillips",
  "Megan Klein",
  "Brianna Fischer",
  "Natalia Whitney",
  "Royce Fields",
  "Adrienne Koch",
  "Marci Hampton",
  "Hipolito Marquez",
  "Arline Archer",
  "Francis Cobb",
  "Fay Rivas",
  "Fidel Hays",
  "Buck Preston",
  "Carla Conrad",
  "Allie Silva",
  "Frances Eaton",
  "Lisa Ferrell",
  "Lizzie Pratt",
  "Deon Mendoza",
  "Francesco Moreno",
  "Shayne Donovan",
  "Fabian Olsen",
  "Laurel Avery",
  "Marisa Barry",
  "Celeste Cortez",
  "Lou Douglas",
  "Eddie Gonzalez",
  "Genaro Cherry",
  "Larry Bell",
  "Boyd Carr",
  "Meghan Craig",
  "Marcellus Harmon",
  "Donn Norton",
  "Stephan Rodgers",
  "Hugh Lawrence",
  "Ina Campbell",
  "Bernard Aguilar",
  "August Hartman",
  "Lelia Snow",
  "Connie Burton",
  "Kelli Hoffman",
  "Phyllis Lowe",
  "Thelma Reese",
  "Gary Andersen",
  "Percy Buck",
  "Shaun Ho",
  "Efrain Mayo",
  "Hillary Pugh",
  "Zachery Hahn",
  "Kermit Cooke",
  "Graham Gibbs",
  "Grant Carson",
  "Freida Curry",
  "Seth Oconnor",
  "Lorraine Powell",
  "Dario Mahoney",
  "Rosario Charles",
  "Warren Holden",
  "Bonnie Holder",
  "Tuan Williamson",
  "Hannah Moyer",
  "Renee Simpson",
  "Otto Warren",
  "Lorena Galvan",
  "Geraldine Gentry",
  "Colleen Rosario",
  "Filiberto Good",
  "Myrna Huber",
  "Josh Ray",
  "Philip Valentine",
  "Cindy Branch",
  "Kirk Holloway",
  "Christopher Sweeney",
  "Hazel Reid",
  "Ricardo Evans",
  "Marjorie Christensen",
  "Glenna Barnett",
  "Dick Pitts",
  "Susanna Ramirez",
  "Manuel Mcgee",
  "Augusta Atkins",
  "Gene Cervantes",
  "Sonny Black",
  "Jamal Sparks",
  "Delmer Bradley",
  "Camille Choi",
  "Julianne Myers"
]

user_count = Enum.count(users)

tracks = [
  "Afghanistan",
  "Albania",
  "Algeria",
  "Andorra",
  "Angola",
  "Antigua and Barbuda",
  "Argentina",
  "Armenia",
  "Australia",
  "Austria",
  "Azerbaijan",
  "Bahamas",
  "Bahrain",
  "Bangladesh",
  "Barbados",
  "Belarus",
  "Belgium",
  "Belize",
  "Benin",
  "Bhutan",
  "Bolivia",
  "Bosnia and Herzegovina",
  "Botswana",
  "Brazil",
  "Brunei",
  "Bulgaria",
  "Burkina Faso",
  "Burundi",
  "Côte d'Ivoire",
  "Cabo Verde",
  "Cambodia",
  "Cameroon",
  "Canada",
  "Central African Republic",
  "Chad",
  "Chile",
  "China",
  "Colombia",
  "Comoros",
  "Congo (Congo-Brazzaville)",
  "Costa Rica",
  "Croatia",
  "Cuba",
  "Cyprus",
  "Czechia (Czech Republic)",
  "Democratic Republic of the Congo",
  "Denmark",
  "Djibouti",
  "Dominica",
  "Dominican Republic",
  "Ecuador",
  "Egypt",
  "El Salvador",
  "Equatorial Guinea",
  "Eritrea",
  "Estonia",
  "Eswatini",
  "Ethiopia",
  "Fiji",
  "Finland",
  "France",
  "Gabon",
  "Gambia",
  "Georgia",
  "Germany",
  "Ghana",
  "Greece",
  "Grenada",
  "Guatemala",
  "Guinea",
  "Guinea-Bissau",
  "Guyana",
  "Haiti",
  "Holy See",
  "Honduras",
  "Hungary",
  "Iceland",
  "India",
  "Indonesia",
  "Iran",
  "Iraq",
  "Ireland",
  "Israel",
  "Italy",
  "Jamaica",
  "Japan",
  "Jordan",
  "Kazakhstan",
  "Kenya",
  "Kiribati",
  "Kuwait",
  "Kyrgyzstan",
  "Laos",
  "Latvia",
  "Lebanon",
  "Lesotho",
  "Liberia",
  "Libya",
  "Liechtenstein",
  "Lithuania",
  "Luxembourg",
  "Madagascar",
  "Malawi",
  "Malaysia",
  "Maldives",
  "Mali",
  "Malta",
  "Marshall Islands",
  "Mauritania",
  "Mauritius",
  "Mexico",
  "Micronesia",
  "Moldova",
  "Monaco",
  "Mongolia",
  "Montenegro",
  "Morocco",
  "Mozambique",
  "Myanmar (formerly Burma)",
  "Namibia",
  "Nauru",
  "Nepal",
  "Netherlands",
  "New Zealand",
  "Nicaragua",
  "Niger",
  "Nigeria",
  "North Korea",
  "North Macedonia",
  "Norway",
  "Oman",
  "Pakistan",
  "Palau",
  "Palestine State",
  "Panama",
  "Papua New Guinea",
  "Paraguay",
  "Peru",
  "Philippines",
  "Poland",
  "Portugal",
  "Qatar",
  "Romania",
  "Russia",
  "Rwanda",
  "Saint Kitts and Nevis",
  "Saint Lucia",
  "Saint Vincent and the Grenadines",
  "Samoa",
  "San Marino",
  "Sao Tome and Principe",
  "Saudi Arabia",
  "Senegal",
  "Serbia",
  "Seychelles",
  "Sierra Leone",
  "Singapore",
  "Slovakia",
  "Slovenia",
  "Solomon Islands",
  "Somalia",
  "South Africa",
  "South Korea",
  "South Sudan",
  "Spain",
  "Sri Lanka",
  "Sudan",
  "Suriname",
  "Sweden",
  "Switzerland",
  "Syria",
  "Tajikistan",
  "Tanzania",
  "Thailand",
  "Timor-Leste",
  "Togo",
  "Tonga",
  "Trinidad and Tobago",
  "Tunisia",
  "Turkey",
  "Turkmenistan",
  "Tuvalu",
  "Uganda",
  "Ukraine",
  "United Arab Emirates",
  "United Kingdom",
  "United States of America",
  "Uruguay",
  "Uzbekistan",
  "Vanuatu",
  "Venezuela",
  "Vietnam",
  "Yemen",
  "Zambia",
  "Zimbabwe"
]

track_count = Enum.count(tracks)

users |> Enum.each(&Mach10.Repo.insert!(%Mach10.Users.User{name: &1, reference: "ref:#{&1}"}))
tracks |> Enum.each(&Mach10.Repo.insert!(%Mach10.Tracks.Track{name: &1, reference: "ref:#{&1}"}))

for track_id <- 1..track_count do
  for user_id <- 1..user_count do
    if :random.uniform(100) <= 90 do
      time = :random.uniform(track_id * 10000) + :random.uniform(10000) + 50000

      Mach10.Repo.insert!(
        %Mach10.Records.Record{track_id: track_id, user_id: user_id, time_ms: time},
        on_conflict: {:replace, [:updated_at, :time_ms]},
        conflict_target: [:track_id, :user_id]
      )
    end
  end
end
