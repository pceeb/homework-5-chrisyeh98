#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(deSolve) 
library(ggplot2)

# Define server logic required to plot various variables
shinyServer(function(input, output) {
  #
  output$ex1 <- renderUI({
    withMathJax(helpText('  $$x(t)=at^2+vt+t$$'))
  })
  output$ex2 <- renderUI({
    withMathJax(
      helpText('$$v(t)=at$$'))
    
  })
  output$ex3 <- renderUI({
    withMathJax(
      helpText("$$a(t)=a$$"))
  })
  
  
  
  
  #latex2exp:TeX
  #output 3 plots, position, velocity, acceleration
  output$PPlot <- reactivePlot(function() {
    eq = function(x){input$p0 + input$v0 * x + input$a * x * x/2 } # note: x represents time here s=s0+v*t+a*t^2, xlab add \n using latex2exp with equation  
    ggplot(data.frame(x=c(0, input$tmax)), aes(x=x)) + stat_function(fun=eq, geom="line") + ggtitle("Position vs Time") + xlab("time") + ylab("meters")
    
    
  })
  output$VPlot <- reactivePlot(function() {
    eq = function(x){input$a*x + input$v0 } #v=a*t+v0
    ggplot(data.frame(x=c(0, input$tmax)), aes(x=x)) + stat_function(fun=eq, geom="line") + ggtitle("Velocity vs Time") + xlab("time") + ylab("m/s")
    
    
  })
  output$APlot <- reactivePlot(function() {
    eq = function(x){ input$a }  #a=a
    ggplot(data.frame(x=c(0, input$tmax)), aes(x=x)) + stat_function(fun=eq, geom="line") + ggtitle("Acceleration vs Time") + xlab("time") + ylab("m/s^2")
    
    
  })
  
  
})

