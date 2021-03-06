###############################################################################
###############################################################################
###############################################################################

## instaluji a loaduji bal��ky ------------------------------------------------

invisible(
    lapply(
        c(
            "openxlsx",
            "xtable"
        ),
        function(package){
            
            if(!(package %in% rownames(installed.packages()))){
                
                install.packages(
                    package,
                    dependencies = TRUE,
                    repos = "http://cran.us.r-project.org"
                )
                
            }
            
            library(package, character.only = TRUE)
            
        }
    )
)


## ----------------------------------------------------------------------------

###############################################################################

## nastavuji pracovn� slo�ku --------------------------------------------------

while(!"script.R" %in% dir()){
    setwd(choose.dir())
}

mother_working_directory <- getwd()


## ----------------------------------------------------------------------------

###############################################################################

## vytv���m poslo�ky pracovn� slo�ky ------------------------------------------

setwd(mother_working_directory)

for(my_subdirectory in c("figures")){
    
    if(!file.exists(my_subdirectory)){
        
        dir.create(file.path(
            
            mother_working_directory, my_subdirectory
            
        ))
        
    }
    
}


## ----------------------------------------------------------------------------

###############################################################################

## ukl�d�m obr�zky ------------------------------------------------------------

setwd(paste(mother_working_directory, "figures", sep = "/"))


## kruskal-wallis -------------------------------------------------------------

cairo_ps(
    file = "one_way_anova.eps",
    width = 7,
    height = 5,
    pointsize = 12
)

par(mar = c(4.1, 4.1, 1.1, 0.1))

set.seed(1) 
    lek_A <- rnorm(30, 20, 3)
    lek_B <- rnorm(30, 15, 3)
    lek_C <- rnorm(30, 12, 3)
    

my_data <- data.frame(
  "mira" = c(lek_A, lek_B, lek_C),
  "lek" = c(rep("A", 30), rep("B", 30),
            rep("C", 30))
)

boxplot(
    mira ~ lek, my_data,
    col = "lightgrey",
    xlab = "l�k"
)

dev.off()


## more-way anova -------------------------------------------------------------

cairo_ps(
    file = "more_way_anova.eps",
    width = 7,
    height = 5,
    pointsize = 12
)

par(mar = c(4.1, 4.1, 1.1, 0.1))

set.seed(1)
my_data <- data.frame(
  "sTK" = c(rnorm(20, 130, 5), rnorm(20, 134, 5),
            rnorm(20, 160, 10), rnorm(20, 140, 10)),
  "faze" = c(rep("p�ed", 20), rep("po", 20),
             rep("p�ed", 20), rep("po", 20)),
  "skupina" = c(rep("kontrola", 40),
                rep("intervence", 40))
)
my_data$faze <- factor(
  my_data$faze, levels = c("p�ed", "po")
)
my_data$skupina <- factor(
  my_data$skupina,
  levels = c("kontrola", "intervence")
)

with(
    my_data,
	interaction.plot(
	    faze, skupina, sTK,
		ylab = "sTK [mm Hg]",
		xlab = "f�ze"
	)
)

dev.off()


## brain vs body --------------------------------------------------------------

cairo_ps(
    file = "brain_vs_body.eps",
    width = 5,
    height = 5,
    pointsize = 12
)

par(mar = c(4.1, 4.1, 0.1, 0.1))

set.seed(1)

plot(
    log(brain) ~ log(body),
	Animals,
	xlab = "log(hmotnost t�la [kg])",
	ylab = "log(hmotnost mozku [g])"
)

abline(
    lm(log(brain) ~ log(body), Animals),
	col = "red"
)

dev.off()


## ----------------------------------------------------------------------------

###############################################################################
###############################################################################
###############################################################################





