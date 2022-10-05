
library(shiny)


shinyServer(function(input, output) {

   dfiinput<-reactive({
     
     ipdf<-data.frame(
       Name = c("Pregnancies",
                "Glucose",
                "BloodPressure",
                "SkinThickness",
              "Insulin",
              "BMI",
              "DPF",
              "Age"),
       Value = as.character(c(input$Pregnancies,
                              input$Glucose,
                              input$BloodPressure,
                              input$SkinThickness,
                            input$Insulin,
                            input$BMI,
                            input$DPF,
                            input$Age)), 
       stringsAsFactors = FALSE
     )
     Outcome<-"Outcome"
     ipdf<-rbind(ipdf,Outcome)
     
     input<-transpose(ipdf)
     write.table(input,"input.csv", sep=",", quote = FALSE, row.names = FALSE, col.names = FALSE)
     
     test1 <- read.csv(paste("input", ".csv", sep=""), header = TRUE)
    

     Output <- data.frame(Result = predict(model,test1))
     print(unname(as.data.frame(Output)),quote = FALSE, row.names = FALSE)
     
   })
   
   output$contents<-renderPrint({if(input$submitbutton>0){
     isolate("Calculation Complete")}
     else{
                                return("Server Ready to Calculate")
     }
})
   output$out<-renderPrint(if(input$submitbutton>0)
     {isolate(dfiinput())})

})
