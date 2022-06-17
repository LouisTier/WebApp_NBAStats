library(shiny)
library(shinythemes)

#Creation de l'interface de notre application 
#Elle va contenir nos différentes pages

navbarPage(strong("BERTHIER - RUGGIERO - NBA Stats"),
           #Création de la premiere page, elle permet de comparer les statistiques de deux joueurs
           tabPanel(em(strong("Comparaison entre les joueurs")),fluidPage(shinythemes::themeSelector()), 
                    tags$head(
                      tags$style(HTML(".shiny-output-error-validation{color: red;}"))),
                    pageWithSidebar(
                      headerPanel(strong('Choix des joueurs')),
                      #On ajoute une "Sidebar" a notre page pour que l'utilisateur puisses chosir les joueurs a comparer
                      sidebarPanel(width = 3,
                                   #Creation du premier outil qui permet de choisir le joueur 1
                                   selectInput('player1', 'Sélectionner le 1er joueur:',paste(data$player,"-",data$team)),
                                   #Creation du deuxieme outil qui permet de choisir le joueur 2
                                   selectInput('player2', 'Sélectionner le 2nd joueur:',paste(data$player,"-",data$team)),
                                   #On ajoute un bouton a notre Sidebar pour que l'utilisateur puisse mettre a jour ses choix
                                   submitButton(strong("Filtrer"))
                      ),
                      
                      #Creation de l'espace ou nos graphiques vont etre affiches
                      mainPanel(
                        #Declaration de nos quatre graphiques a afficher
                        #Ils ont ete definis dans le script "server.R"
                        column(6, plotlyOutput("plot_radar", width = 500, height= 500, inline = TRUE)),
                        
                        column(6, plotlyOutput("plot_radar_pct", width = 500, height=500, inline = TRUE)),
                        
                        column(6, plotlyOutput("plot_hist_salaire", width = 500, height=500, inline = TRUE)),
                        
                        column(6, plotlyOutput("plot_boxplot", width = 700, height=700, inline = TRUE))
                      )
                    )
           ),
           
           tabPanel(em(strong("Comparaison entre les équipes")),
                    headerPanel(strong('Options de filtrage')),
                    sidebarPanel(width = 3,
                                 tags$style(HTML(".js-irs-0 .irs-single, .js-irs-0 .irs-bar-edge, .js-irs-0 .irs-bar, .js-irs-0 .irs-slider {background: red}")),
                                 tags$style(HTML(".js-irs-1 .irs-single, .js-irs-1 .irs-bar-edge, .js-irs-1 .irs-bar, .js-irs-1 .irs-slider {background: green}")),
                                 sliderInput("Age", "Age moyen au sein de l'équipe :",min = 19, max = 35, value = c(19,35)),
                                 sliderInput("Win", "Nombre moyen de victoires par équipe :",min = 10, max = 40, value = c(10,40)),
                                 submitButton(strong("Rechercher")),
                                 br(),
                                 p(em(strong("Indication : Chaque bulle a une taille différente qui correspond au nombre moyen de victoires de l'équipe concernée")))
                    ),
                    
                    
                    
                    mainPanel(
                      #Declaration de nos quatre graphiques a afficher
                      #Ils ont ete definis dans le script "server.R"
                      column(6, plotlyOutput("diag_bulles", width = 1000, height= 700, inline = TRUE),
                             column(6, DT::dataTableOutput("mytable")))
                    )
           ),
           
           #Création d'une page d'annexe qui va preciser la signification de nos donnees
           tabPanel(em(strong("Description des abbréviations")),
                    
                    hr(), 
                    
                    h1(strong("Voici le glossaire à utiliser afin de comprendre les abbréviations présentes au sein des différents graphiques :", style = "font-size:30px")),
                    br(),
                    h4(em("Précision : Ces données représentent les statistiques en moyenne par match sur l'année")),
                    br(),
                    
                    hr(),
                    
                    h2(strong("1. Description générale"), style = "font-size:24px"),
                    br(),
                    
                    p(style = "font-size:15px;color: blue", 
                      strong("GP :"), "Nombre de matchs joués",
                      strong("| W :"), "Nombre de victoires", 
                      strong("| L :"), "Nombre de défaites",
                      strong("| MIN"), "Temps joué en minutes"
                    ), 
                    br(),
                    
                    p(style = "font-size:15px;color: blue",
                      strong("W_PCT :"), "Pourcentage de victoires",
                      strong("| FG_PCT :"), "Pourcentage de paniers marqués",
                      strong("| FG3_PCT :"), "Pourcentage de paniers marqués à 3 points",
                      strong("| FT_PCT :"), "Pourcentage de lancers francs marqués"
                    ),
                    br(),
                    
                    p(style = "font-size:15px;color: blue", 
                      strong("FGM :"), "Nombre de paniers marqués",
                      strong("| FGA :"), "Nombre de tentatives de paniers",
                      strong("| FG3M :"), "Nombre de paniers marqués à 3 points",
                      strong("| FG3A :"), "Nombre de tentatives de paniers à 3 points",
                      strong("| FTM :"), "Nombre de lancers francs marqués",
                      strong("| FTA :"), "Nombre de tentatives de lancers francs"
                    ),
                    br(),
                    
                    p(style = "font-size:15px;color: blue", 
                      strong("REB :"), "Nombre total de rebonds",
                      strong("| OREB :"), "Nombre de rebonds offensifs",
                      strong("| DREB :"), "Nombre de rebonds defensifs"
                    ),
                    br(),
                    
                    
                    p(style = "font-size:15px;color: blue", 
                      strong("AST :"), "Nombre de passes décisives",
                      strong("| TOV :"), "Nombre de pertes de balles",
                      strong("| STL :"), "Nombre d'interceptions"
                    ),
                    br(),
                    
                    p(style = "font-size:15px;color: blue", 
                      strong("BLK :"), "Nombre de contres",
                      strong("| BLKA :"), "Nombre de tentatives de contres",
                      strong("| PF :"), "Nombre de fautes personnelles",
                      strong("| PFD :"), "Nombre de fautes personnelles défensives"
                    ),
                    br(),
                    
                    p(style = "font-size:15px;color: blue", 
                      strong("PTS :"), "Nombre de points marqués",
                      strong("| NBA_FANTASY_PTS :"), "Score fantaisiste qui prend en compte des points différents de ceux marqués"
                    ),
                    br(),
                    
                    p(style = "font-size:15px;color: blue", strong("Salaire :"), "Salaire du joueur en million de dollars ($)"),
                    br(),
                    
                    hr(),
                    
                    h2(strong("2. Description par rang"), style = "font-size:24px"),
                    br(),
                    
                    p(style = "font-size:15px;color: purple", 
                      strong("GP_RANK :"), "Rang vis-à-vis du nombre de matchs joués",
                      strong("| W_RANK :"), "Rang vis-à-vis du nombre de victoires", 
                      strong("| L_RANK :"), "Rang vis-à-vis du nombre de defaites",
                      strong("| MIN_RANK"), "Rang vis-à-vis du temps joué"
                    ), 
                    br(),
                    
                    p(style = "font-size:15px;color: purple",
                      strong("W_PCT_RANK :"), "Rang vis-à-vis du pourcentage de victoires",
                      strong("| FG_PCT_RANK :"), "Rang vis-à-vis du pourcentage de paniers marqués",
                      strong("| FG3_PCT_RANK :"), "Rang vis-à-vis du pourcentage de paniers marqués à 3 points",
                      strong("| FT_PCT_RANK :"), "Rang vis-à-vis du pourcentage de lancers francs marqués"
                    ),
                    br(),
                    
                    p(style = "font-size:15px;color: purple", 
                      strong("FGM_RANK :"), "Rang vis-à-vis du nombre de paniers marqués",
                      strong("| FGA_RANK :"), "Rang vis-à-vis du nombre de tentatives de paniers",
                      strong("| FG3M_RANK :"), "Rang vis-à-vis du nombre de paniers marqués à 3 points",
                      strong("| FG3A_RANK :"), "Rang vis-à-vis du nombre de tentatives de paniers à 3 points",
                      strong("| FTM_RANK :"), "Rang vis-à-vis du nombre de lancers francs marqués",
                      strong("| FTA_RANK :"), "Rang vis-à-vis du nombre de tentatives de lancers francs"
                    ),
                    br(),
                    
                    p(style = "font-size:15px;color: purple", 
                      strong("REB_RANK :"), "Rang vis-à-vis du nombre total de rebonds",
                      strong("| OREB_RANK :"), "Rang vis-à-vis du nombre de rebonds offensifs",
                      strong("| DREB_RANK :"), "Rang vis-à-vis du nombre de rebonds defensifs"
                    ),
                    br(),
                    
                    p(style = "font-size:15px;color: purple", 
                      strong("AST_RANK :"), "Rang vis-à-vis du nombre de passes décisives",
                      strong("| TOV_RANK :"), "Rang vis-à-vis du nombre de pertes de balles",
                      strong("| STL_RANK :"), "Rang vis-à-vis du nombre d'interceptions"
                    ),
                    br(),
                    
                    p(style = "font-size:15px;color: purple", 
                      strong("BLK_RANK :"), "Rang vis-à-vis du nombre de contres",
                      strong("| BLKA_RANK :"), "Rang vis-à-vis du nombre de tentatives de contres",
                      strong("| PF_RANK :"), "Rang vis-à-vis du nombre de fautes personnelles",
                      strong("| PFD_RANK :"), "Rang vis-à-vis du nombre de fautes personnelles défensives"
                    ),
                    br(),
                    
                    p(style = "font-size:15px;color: purple", 
                      strong("PTS_RANK :"), "Rang vis-à-vis nombre de points marqués",
                      strong("| NBA_FANTASY_PTS_RANK :"), "Rang vis-à-vis score fantaisiste"
                    ),
                    br()),
           
           
           
           #Création d'une page contenant les developpeurs de cette application
           tabPanel(em(strong("Développeurs")),

                    sidebarPanel(
                      width = 6,
                      h1(strong("Louis BERTHIER"),style = "font-size:35px; color:orange"),
                      br(),
                      p("Vous pouvez me contacter à l'adresse mail suivante :",strong("louis.berthier@mines-ales.org"),style = "font-size:20px"),
                      br(),
                      p("Vous pouvez retrouver mon profil LinkedIn",strong(a("ici",href = "https://www.linkedin.com/in/louis-berthier-5489211ba/")),style = "font-size:20px" ),
                      br(),
                      img(src = "https://media-exp1.licdn.com/dms/image/C5603AQH9qVAUY1t0dA/profile-displayphoto-shrink_400_400/0/1635018934727?e=1657152000&v=beta&t=WsLgl2QfzBM0YIR5KqLu3JidSy01u0jFNkdh-5LeEX4", style="display: block; margin-left: auto; margin-right: auto;")
                    ),
                    
                    sidebarPanel(
                      width = 6,
                      h1(strong("Adrien RUGGIERO"),style = "font-size:35px; color:purple"),
                      br(),
                      p("Vous pouvez me contacter à l'adresse mail suivante :",strong("adrien.ruggiero@mines-ales.org"),style = "font-size:20px"),
                      br(),
                      p("Vous pouvez retrouver mon profil LinkedIn",strong(a("ici",href = "https://www.linkedin.com/in/adrien-ruggiero/")),style = "font-size:20px" ),
                      br(),
                      img(src = "https://media-exp1.licdn.com/dms/image/C4E03AQEbMxvVqtlWfg/profile-displayphoto-shrink_400_400/0/1631907094495?e=1657152000&v=beta&t=cvIQ_Qrh8MYm_lNRsslLKHA8zZmNPWJjFssEkyd9beI", style="display: block; margin-left: auto; margin-right: auto;")
                    ),
                  
                    br(),
                    p(strong("Notre projet est disponible juste",a("ici.",href ="https://imtminesales-my.sharepoint.com/:f:/g/personal/louis_berthier_mines-ales_org/EhPGf8Z8ot1LlQfJtae81sMBxzXwlADe9mN2Ax90DpjEVg?e=ZMoVbk"),"Vous y trouverez notre rapport ainsi que notre code.",style = "font-size:30px")),
                    
           )
           
)
