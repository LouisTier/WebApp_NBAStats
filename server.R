library(shiny)

function(input, output, session) {
  
  #On vient chercher les donnees utiles pour le premier graphe du premier joueur que l'utilisateur a selectionne 
  Joueur1 <- reactive({
    data %>%
    select(12,15,16,18,19,21,22,23,24,25,26,27,28,29,30) %>%
     filter(data$player == gsub("[[:space:]]*$","",gsub("- .*",'',input$player1))) 
  })
  
  #On vient chercher les donnees utiles pour le deuxieme graphe du premier joueur que l'utilisateur a selectionne 
  Joueur1_pct <- reactive({
    data %>%
      select(14,17,20) %>%
      filter(data$player == gsub("[[:space:]]*$","",gsub("- .*",'',input$player1))) 
  })
  
  #On vient chercher les donnees personnel du joueur 1
  InfosPersos1 <- reactive({
    data %>%
      select(player,age, SALARIES) %>%
      filter(data$player == gsub("[[:space:]]*$","",gsub("- .*",'',input$player1))) 
  })
  
  #On fait la meme chose avec le deuxieme joueur selectionne
  Joueur2 <- reactive({
    data %>%
      select(12,15,16,18,19,21,22,23,24,25,26,27,28,29,30) %>%
      filter(data$player == gsub("[[:space:]]*$","",gsub("- .*",'',input$player2))) 
  })
  
  Joueur2_pct <- reactive({
    data %>%
      select(14,17,20) %>%
      filter(data$player == gsub("[[:space:]]*$","",gsub("- .*",'',input$player2))) 
  })
  
  InfosPersos2 <- reactive({
    data %>%
      select(player,age, SALARIES) %>%
      filter(data$player == gsub("[[:space:]]*$","",gsub("- .*",'',input$player2))) 
  })
  
  #On creer nos plot qui seront affiches 
  output$plot_radar <- renderPlotly({
    
    #On creer les donnees qui seront implementees pour notre diagramme "radar"
    r1 = map_dbl(Joueur1(), ~.x)
    r2 = map_dbl(Joueur2(), ~.x)
    
    plot_ly(
      #definition des parametres du plot
      width = 500,
      height = 500,
      type = 'scatterpolar',
      mode = "closest",
      fill = 'toself'
    ) %>%
      #On ajoute ici les donnees du joueur 1 au graphique
      add_trace(
        r =r1,
        #Le nom des donnees qui seront affichees dans le graphique
        theta = names(Joueur1()[3,]),
        showlegend = TRUE,
        mode = "markers",
        #on affiche le nom du joueur dans la legende, en cliquant dessus,
        #les donnees relatives au joueur peuvent etre activees/desactivees
        name = InfosPersos1()[1,1]
      ) %>%
      #On fait exactement la meme chose mais pour le joueur 1
      add_trace(
        r =r2,
        theta = names(Joueur2()[3,]),
        showlegend = TRUE,
        mode = "markers",
        name = InfosPersos2()[1,1]
      ) %>%
      
      #Definition des parametres d'affichage du plot
      layout(
        polar = list(
          radialaxis = list(
            #on choisit d'afficher les graduations
            visible = T,
            #on definit l'echelle du graphique
            #On prend le maximum de toutes les donnees +3 pour ne pas qu'ont ait 
            #une valeur au bord du graphique
            range = c(0,max(r1,r2)+3)
          )
        ),
        
        #definition du titre du graphique
        title = "Confrontation des performances sportives des joueurs",
        showlegend=TRUE
      )
  })
  
  #Creation du deuxieme diagramme "radar"
  #On reprend le meme processus que le graphe precedent mais ici
  #on ne vient afficher que les donnees sous forme de pourcentage
  output$plot_radar_pct <- renderPlotly({
    
    r1_pct = map_dbl(Joueur1_pct(), ~.x)
    r2_pct = map_dbl(Joueur2_pct(), ~.x)
    
    plot_ly(
      width = 500,
      height = 500,
      type = 'scatterpolar',
      mode = "closest",
      fill = 'toself'
    ) %>%
      
      add_trace(
        #On multiplie par 100 pour avoir les donnees en pourcentage
        r = 100*r1_pct,
        theta = names(Joueur1_pct()[3,]),
        showlegend = TRUE,
        mode = "markers",
        name = InfosPersos1()[1,1]
      ) %>%
      
      add_trace(
        #On multiplie par 100 pour avoir les donnees en pourcentage
        r = 100* r2_pct,
        theta = names(Joueur2_pct()[3,]),
        showlegend = TRUE,
        mode = "markers",
        name = InfosPersos2()[1,1]
      ) %>%
      
      layout(
        polar = list(
          radialaxis = list(
            visible = T,
            #Ici l'echelle d'affichage va de 0 à 100 car on affiche des pourcentages
            range = c(0,100)
            
          )
        ),
        title = "Comparaison en % des performances entre les joueurs",
        showlegend=TRUE
      )
  })
  
  #Creation de l'histogramme qui va comparer les salaires des joueurs
  output$plot_hist_salaire <- renderPlotly({
    
    #On vérifie si les joueurs sont les meme ou non
    if(InfosPersos1()[1,1] == InfosPersos2()[1,1] )
    {
      #si les joueurs sont les memes, on affiche qu'une  seule barre
      #a notre histogramme
      x = c(InfosPersos1()[1,1])
      y = c(InfosPersos1()[1,3])
      
      #On definit la couleur du joueur (Vert)
      marker = list(color = rgb(76,153,0, maxColorValue = 255))
    }
    else
    {
    #Si on compare bien deux joueurs differents, 
    #on va bien afficher les barres relatives a chacun des joueurs 
    x = c(InfosPersos1()[1,1], InfosPersos2()[1,1])
    y = c(InfosPersos1()[1,3], InfosPersos2()[1,3])
    marker = list(color = c(rgb(255,178,102, maxColorValue = 255),rgb(76,153,0, maxColorValue = 255)))
    }
    
    plot_ly(
      type = 'bar',
      x=x,
      y=y,
      marker = marker
      )%>%
      layout(title="Affichage des salaires en million de dollars ($)")
  })
  
  #On vient chercher 3 statistiques de tous les joueurs afin
  #d'en faire des boites a moustaches
  All_boxplot <- reactive({
    data %>%
      select(GP,W_PCT,PTS) 
  })
  
  #On vient chercher ces meme trois statistiques pour les afficher sur les boites
  #a moustaches afin de postionner le joueur 1 par rapport aux autres
  Joueur1_boxplot <- reactive({
    data %>%
      select(player,GP,W_PCT,PTS) %>%
      filter(data$player == gsub("[[:space:]]*$","",gsub("- .*",'',input$player1))) 
  })
  
  #On fait de meme avec le joueur 2
  Joueur2_boxplot <- reactive({
    data %>%
      select(player,GP,W_PCT,PTS) %>%
      filter(data$player == gsub("[[:space:]]*$","",gsub("- .*",'',input$player2))) 
  })
  
  #On affiche les 3 box plots sous forme de subplot 
  output$plot_boxplot <- renderPlotly({
    
    #On stocke notre dataframe contenant les statistiques de tous les joueurs
    all_players = All_boxplot()
    
    #Premier boxplot qui porte sur le nombre de matchs joues
     fig_GP <- plot_ly(
       data = all_players,
      name = names(all_players)[1],
      #On selectionne la colonne GP i.e le nombre de matchs joues
      y = ~GP,
      type = 'box',
      #On affiche la barre de la moyenne 
      boxmean = TRUE
    )%>% 
       #On ajoute une barre qui reprensente le joueur1 en orange
       add_trace(Joueur1_boxplot(), y = Joueur1_boxplot()[1,2], showlegend=FALSE, marker = list(color = rgb(255,178,102, maxColorValue = 255)))%>%
       #Idem pour le joueur 2 en vert
       add_trace(Joueur2_boxplot(), y = Joueur2_boxplot()[1,2], showlegend=FALSE, marker = list(color = rgb(76,153,0, maxColorValue = 255)))
    
    #Deuxieme boxplot pour le nombre de points gagnes
     fig_PTS <- plot_ly(
       data = all_players,
       name = names(all_players)[3],
       y = ~PTS,
       type = 'box',
       boxmean = TRUE
     )%>% add_trace(Joueur1_boxplot(), y = Joueur1_boxplot()[1,4], showlegend=FALSE, marker = list(color = rgb(255,178,102, maxColorValue = 255)))%>%
          add_trace(Joueur2_boxplot(), y = Joueur2_boxplot()[1,4], showlegend=FALSE, marker = list(color = rgb(76,153,0, maxColorValue = 255)))
     
     #Troisieme boxplot pour le pourcentage de victoires
     fig_W_PCT <- plot_ly(
       data = all_players,
       name = names(all_players)[2],
       y = ~W_PCT,
       type = 'box',
       boxmean = TRUE
     )%>% add_trace(Joueur1_boxplot(), y = Joueur1_boxplot()[1,3], showlegend=FALSE, marker = list(color = rgb(255,178,102, maxColorValue = 255)))%>%
       add_trace(Joueur2_boxplot(), y = Joueur2_boxplot()[1,3], showlegend=FALSE, marker = list(color = rgb(76,153,0, maxColorValue = 255)))
          
     #On rassemble nos trois boxplot sous forme de subplot qu'on affichera dans l'application
     fig <- subplot(fig_GP, fig_PTS, fig_W_PCT)%>%
        layout(title="Evaluation générale des deux joueurs", showlegend = FALSE)
  })
  
  d1 <- data
  d2 <- data
  ##PARTIE POUR LA PAGE "EQUIPE"
  
  #On creer un dataframe qui contient le nombre moyen de victoires d'une equipe 
  #selon les criteres choisis par l'utilisateur
  filtre_wins <- reactive({
    
    data %>% select(team,W) %>%
      group_by(team) %>% summarise("W" = mean(W)) %>%
      filter(W > input$Win[1]) %>% filter(W < input$Win[2])
  })
  
  filtre_tirs <- reactive({
    data %>% select(team,age) %>%
      group_by(team) %>% summarise("age" = mean(age)) %>%
      filter(age > input$Age[1]) %>% filter(age < input$Age[2])
  })
  
  filtre_final <- reactive({merge(filtre_wins(),filtre_tirs())})
  
  donnees_affichage <- reactive({
    data %>% group_by(team)  %>% summarise_if(is.numeric, mean)
  })
  
  #on rassemble le dataframe precedent avec le nombre moyen de victoires
  #cela nous permet dans le meme temps de ne garder que les equipes qui 
  #respectent le nombre moyen de victoires impose par l'utilisateur
  data_plot1 <- reactive({merge(donnees_affichage(),filtre_final())})
  
  #on creer notre diagramme a bulles avec en abscisse la categorie 1,
  #en ordonnee la categorie 2 et la taille de chaque point sera le
  #nombre moyen de victoires pour chaque equipe
  output$diag_bulles <- renderPlotly({
    plot_ly(data_plot1(), x = ~PF, y=~PTS , name= ~team, type = 'scatter', size = ~W, mode = 'markers',
            marker = list(color = ~team, alpha = 0.5)) %>% layout(title = "Opposition globale entre les équipes")
  })
  
}
