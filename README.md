# Pokedex Dashboard

The goal of this web application is to provide Pokémon core game players some insights about the Pokémons that would fit specific roles in their team.

The data set used has been posted on Kaggle by [Alberto Barradas](https://www.kaggle.com/abcsds/pokemon). Using R, I added to that data set some information for the sake of representability and ease of filtering.

This application takes the form of a dashboard fully built in R, using the package "shiny". The application is currently deployed on a shinyapps.io server, available [here.](https://l2cgauthier.shinyapps.io/PokedexAnalysis/)

# Features

The data set contains 721 entries which all correspond to a Pokémon (or a Pokémon’s alternate form). Each individual of the data set comes with the following 13 features:

-	Id (numeric): a number that is supposed to identify uniquely every Pokémon. This is not really the case anymore as there are now alternate forms of Pokémons (such as Mega Evolutions). This number is mainly used as a fast reference to a Pokémon, which also gives information on its generation.
-	Name (string): the name of the Pokémon. It also uses a weird convention for alternate forms with for example, names like “VenusaurMega Venusaur”. we had to change this formatting for readability.
-	Type 1 (category): each Pokémon has a primary type that is picked from the 18 existing types.
-	Type 2 (category): similar to type 1 except some Pokémons don’t have a secondary type which translates into missing values.
-	HP, Attack, Defense, Sp. Attack, Sp. Defense, Speed (numeric, int): basic statistic of each Pokémon.
-	Total (numeric, int): sum of the basic statistics of Pokémons. It can give an estimate of a Pokémon’s strength.
-	Generation (numeric but treated as category): this describe the game and the time period during which the Pokémons were created.
-	Legendary (boolean): traditionally, legendary Pokémons are obtainable through different means than non-legendary ones. They are usually part of the main story of the games.

# Application architecture

## Side bar: inputs

The sidebar is the area where the user interacts with the dashboard. It is where the user can input various parameters. Every input is used to filter the content displayed in every tab.

The user has the ability to filter the data presented on any feature available in the data set. In order to have a readable sidebar that is not too cluttered, we used nested menu items. The user clicks on increasingly precise menu items until he reaches the actual input that will filter the data.

For instance, in order to filter only Pokémons with an HP statistic of more than 140, the user first clicks on “Statistics”, then on “HP”. He can then select values of lower and higher bound of HP thanks to a double-sided slider.

## First tab: best overall Pokémon

This tab is aimed at displaying the best Pokémon in the filtered subset defined by the user’s inputs. This tab is structured in 3 boxes.

-	The first box contains the picture and the statistics of the best Pokémon in the subset. The picture is externally stored. It is displayed by rendering some HMTL containing the picture’s URL as text. The statistics of the Pokémon are displayed as a simple histogram built using ggplot2 and made interactable as a plotly item via the ggplotly function. In order to control the information displayed on hover, we used the unofficial aesthetic parameter ‘text’ and the tooltip optional argument of the ggplotly function. This trick is used on every other plot in the web application.

-	The second box contains a plot showing the top 6 Pokémons of the subset (or less if there are less than 6 Pokémons in the subset). For each Pokémon, we show its statistics and their sum as stacked bar plot. In order to build it, we first extract the top 6 Pokémons based on the feature ‘Total’ and then convert these in a long format, with the melt function from the reshape2 package. Then we used the classical ggplot and ggplotly workflow.

-	The third and last box contains a scatter plot used to provide a synthetic view of the subset of the Pokémons contained in the subset defined by the user. The x-axis measures the offensivity of a Pokémon, and the y-axis it’s overall power. Then the colour of each Pokémon represents its best basic statistic. At first, it is not the most readable plot, but as the user adds filters, the subset of Pokémon displayed shrinks and the plot gains is readability and usability. Its main use is to give the user the ability to hover on specific points to explore potential Pokémons to fill specific role in their team.

## Second tab: Best Pokémons based on specific statistics

Sometimes, the best overall Pokémon is just not the right one for players with very specific needs. Sometimes a user will need the most defensive Pokémon in the subset, or the one with the highest speed. The second tab is aimed at satisfying those users.

It contains 6 bar plots, one for each basic Pokémon statistic. For each of these statistics, a plot shows the top 6 Pokémons in the subset based only on that statistics. Most of the time the result is very different from the result shown in the first tab.

## Third tab: Data table 

The third tab contains a table showing the raw, filtered data. This table allow the user to order the entries following specific variables, and also allow text search, which can be useful when looking for a specific Pokémon by its name. Of course, this table only show the useful features to the user for better usability and readability.

By default, the table shows 14 entries which should fill the screen of a maximised web browser. Looking into the way the final shiny HTML – CSS code is built, we were able to style the table to follow the global design of the application by using CSS elements.

# Conclusion

In the end, the web application built offers simple theorycrafting tools to Pokémon core game players looking for the perfect Pokémon team. It shows synthetic information about a subset of Pokémons defined by the user’s inputs.

Numerous aspects of the application could still be vastly improved. For example, while the application works very well in maximised browsers, it doesn’t behave well when the size of the window varies, because some elements are defined with a fixed size. Among other weaknesses, we can mention the lack of a different picture for Pokémon’s alternate form, and the lack of the Pokémons from Generation VII.

# Screenshots

![](https://github.com/L2cGauthier/PokedexDashboard/blob/master/Screenshots/Screenshot1.png)

![](https://github.com/L2cGauthier/PokedexDashboard/blob/master/Screenshots/Screenshot2.png)

![](https://github.com/L2cGauthier/PokedexDashboard/blob/master/Screenshots/Screenshot3.png)
