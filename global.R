options(encoding = "UTF-8")

#On liste tous les packages qui seront utilisés
packages = c("shiny", "shinydashboard", "shinythemes", "plotly", "shinycssloaders","tidyverse",
            "scales", "knitr", "kableExtra", "ggfortify","dplyr","plotly","FNN")

#On vérifie que les packages du dessus sont bien installés, sinon on les installe.
package.check <- lapply(packages, FUN = function(x) {
  if (!require(x, character.only = TRUE)) {
    install.packages(x, dependencies = TRUE)
  }
})

#On importe notre base de données
data <- read.csv2("NBA_data_R.csv",header=TRUE,sep=";")
names(data)[1] <- "player"  #On renomme la colonne en "player"
names(data)[5] <- "team"    #On renomme la colonne en "team"
names(data)[6] <- "age"     #On renomme la colonne en "age"


#On transforme le type de certaines colonnes en "double" pour pouvoir les exploiter
data$age <- as.numeric(data$age)
data$MIN <- as.numeric(data$MIN)
data$FGM <- as.numeric(data$FGM)
data$FGA <- as.numeric(data$FGA)
data$FG_PCT <- as.numeric(data$FG_PCT)
data$W_PCT <- as.numeric(data$W_PCT)
data$FG_PCT <- as.numeric(data$FG_PCT)
data$FG3M <- as.numeric(data$FG3M)
data$FG3A <- as.numeric(data$FG3A)
data$FG3_PCT <- as.numeric(data$FG3_PCT)
data$FTM <- as.numeric(data$FTM)
data$FTA <- as.numeric(data$FTA)
data$FT_PCT <- as.numeric(data$FT_PCT)
data$OREB <- as.numeric(data$OREB)
data$DREB <- as.numeric(data$DREB)
data$REB <- as.numeric(data$REB)
data$AST <- as.numeric(data$AST)
data$TOV <- as.numeric(data$TOV)
data$STL <- as.numeric(data$STL)
data$BLK <- as.numeric(data$BLK)
data$BLKA <- as.numeric(data$BLKA)
data$PF <- as.numeric(data$PF)
data$PFD <- as.numeric(data$PFD)
data$PTS <- as.numeric(data$PTS)
